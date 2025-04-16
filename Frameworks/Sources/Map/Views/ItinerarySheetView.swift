//
//  ItinerarySheetView.swift
//  Frameworks
//
//  Created by William Fort on 12/02/2025.
//

import Combine
import SwiftUI
import Tools

public protocol ItinerarySheetViewModelProtocol: ObservableObject {
    var sheetState: DraggableSheetViewModel.SheetState { get }
    var publishedSheetState: Published<DraggableSheetViewModel.SheetState> { get }

    func updateSheetState(to state: DraggableSheetViewModel.SheetState)

    var publishedIsHeightLocked: Published<Bool> { get }

    func updateIsHeightLocked(to value: Bool)
}

public final class ItinerarySheetViewModel: ItinerarySheetViewModelProtocol, ObservableObject {
    @Published public private(set) var sheetState: DraggableSheetViewModel.SheetState = .minimized
    @Published private var isHeightLocked: Bool = false

    private var anyCancellable = Set<AnyCancellable>()
    public init() {
        $sheetState.sink { state in
            print(state)
        }
        .store(in: &anyCancellable)

        $isHeightLocked.sink { value in
            print(value)
        }
        .store(in: &anyCancellable)
    }

    public var publishedSheetState: Published<DraggableSheetViewModel.SheetState> {
        _sheetState
    }

    public func updateSheetState(to state: DraggableSheetViewModel.SheetState) {
        sheetState = state
    }

    public var publishedIsHeightLocked: Published<Bool> {
        _isHeightLocked
    }

    public func updateIsHeightLocked(to value: Bool) {
        isHeightLocked = value
    }
}

public struct ItinerarySheetView<ViewModel: ItinerarySheetViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel

    @State private var isSheetPresented: Bool = true
    @State private var departure: String = ""
    @State private var arrival: String = ""
    @State private var showRouteBlock: Bool = false // Gère l'affichage du bloc trajet
    @State private var sheetDetent: PresentationDetent = .fraction(0.5) // Taille du Bottom Sheet

    // Vérifie si les deux champs sont remplis
    private var isFormValid: Bool {
        !departure.isEmpty && !arrival.isEmpty
    }

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            Spacer()

            // Bouton flottant au-dessus du sheet
            HStack {
                Spacer()
                Button(action: {
                    // Action du bouton flottant
                }) {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Circle().fill(Color.white))
                        .shadow(radius: 10)
                }
                .padding([.top, .trailing], 20)
            }
        }
        .draggableSheet(isPresented: $isSheetPresented,
                        state: viewModel.publishedSheetState,
                        isHeightLocked: viewModel.publishedIsHeightLocked) {
            ZStack {
                VStack(spacing: 20) {
                    // Section des boutons "Home", "Travail", "Autre"
                    FavoriesStack()
                    // Inputs "Départ" et "Arrivée" avec bouton d'inversion
                    TripAddressFieldsView(departure: $departure,
                                          arrival: $arrival)
                    // Affichage du bloc trajet après soumission
                    if showRouteBlock {
                        HStack(spacing: 15) {
                            Image(systemName: "car.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color("AccentColor"))

                            Text("Trajet 1")
                                .font(.headline)
                                .foregroundColor(Color("TextsColor"))

                            Spacer()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .transition(.opacity)
                    }

                    // Texte cliquable "Plus de paramètres"
                    Button(action: {}) {
                        HStack {
                            Image("more", bundle: .main)
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text("Plus de paramètres")
                                .foregroundColor(Color("TextsColor"))
                        }
                    }

                    // Bouton de soumission "Allons-y"
                    Button(action: {
                        withAnimation {
                            showRouteBlock = true  // Afficher le bloc trajet
                            viewModel.updateIsHeightLocked(to: true)
                            viewModel.updateSheetState(to: .fullScreen)
                        }
                    }) {
                        Text("ALLONS-Y")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isFormValid ? Color.accentColor : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .opacity(isFormValid ? 1.0 : 0.6)
                    }
                    .disabled(!isFormValid)
                }
            }
            .padding()
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ItinerarySheetView(viewModel: ItinerarySheetViewModel())
}
