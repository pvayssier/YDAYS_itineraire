//
//  View+DraggableSheetView.swift
//  Frameworks
//
//  Created by Paul Vayssier on 12/02/2025.
//

import SwiftUI
import Combine

extension View {
    public func draggableSheet<Content: View>(
        isPresented: Binding<Bool>,
        state: Published<DraggableSheetViewModel.SheetState>,
        isHeightLocked: Published<Bool> = .init(initialValue: false),
        minHeight: CGFloat = 180,
        midHeight: CGFloat = 400,
        maxHeight: CGFloat = UIScreen.main.bounds.height * 0.95,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.overlay(
            Group {
                if isPresented.wrappedValue {
                    DraggableSheetView(
                        isPresented: isPresented,
                        viewModel: DraggableSheetViewModel(state: state,
                                                           minHeight: minHeight,
                                                           midHeight: midHeight,
                                                           maxHeight: maxHeight),
                        content: content
                    )
                    .transition(.move(edge: .bottom))
                }
            }
        )
        .animation(.easeInOut, value: isPresented.wrappedValue)
    }
}

public final class DraggableSheetViewModel: ObservableObject {
    public enum SheetState {
        case hidden
        case minimized
        case halfScreen
        case fullScreen
    }

    @Published var state: SheetState
    @Published private(set) var isHeightLocked: Bool
    @Published var sheetHeight: CGFloat = 0

    let minHeight: CGFloat
    let midHeight: CGFloat
    let maxHeight: CGFloat

    private var cancellables = Set<AnyCancellable>()

    init(state: Published<SheetState> = .init(initialValue: .hidden),
         isHeightLocked: Published<Bool> = .init(initialValue: false),
         minHeight: CGFloat,
         midHeight: CGFloat,
         maxHeight: CGFloat) {
        self._state = state
        self._isHeightLocked = isHeightLocked

        self.minHeight = minHeight
        self.midHeight = midHeight
        self.maxHeight = maxHeight

        $state.sink { [weak self] state in
            switch state {
            case .hidden:
                self?.sheetHeight = 0
            case .minimized:
                self?.sheetHeight = minHeight
            case .halfScreen:
                self?.sheetHeight = midHeight
            case .fullScreen:
                self?.sheetHeight = maxHeight
            }
        }
        .store(in: &cancellables)
    }
}

struct DraggableSheetView<Content: View>: View {
    @Binding var isPresented: Bool
    @ObservedObject private var viewModel: DraggableSheetViewModel

    @State private var dragOffset: CGFloat = 0

    let content: () -> Content

    init(
        isPresented: Binding<Bool>,
        viewModel: DraggableSheetViewModel,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.viewModel = viewModel
        self.content = content
    }

    var body: some View {
        VStack {
            Capsule()
                .frame(width: 50, height: 6)
                .foregroundColor(.gray.opacity(0.6))
                .padding(5)

            content()

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: viewModel.sheetHeight + dragOffset)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .offset(y: UIScreen.main.bounds.height / 2 - (dragOffset + viewModel.sheetHeight) / 2)
        .gesture(
            DragGesture()
                .onChanged { value in
                    guard !viewModel.isHeightLocked else { return }
                    let newHeight = viewModel.sheetHeight - value.translation.height
                    if newHeight >= viewModel.minHeight, newHeight <= viewModel.maxHeight {
                        dragOffset = -value.translation.height
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        let newHeight = viewModel.sheetHeight + dragOffset
                        if newHeight > (viewModel.midHeight + viewModel.maxHeight) / 2 {
                            viewModel.sheetHeight = viewModel.maxHeight
                            viewModel.state = .fullScreen
                        } else if newHeight > (viewModel.minHeight + viewModel.midHeight) / 2 {
                            viewModel.sheetHeight = viewModel.midHeight
                            viewModel.state = .halfScreen
                        } else {
                            viewModel.sheetHeight = viewModel.minHeight
                            viewModel.state = .minimized
                        }
                        dragOffset = 0
                    }
                }
        )
    }
}
