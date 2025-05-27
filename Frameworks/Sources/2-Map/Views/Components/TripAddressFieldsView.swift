//
//  TripAddressFieldsView.swift
//  Frameworks
//
//  Created by Paul Vayssier on 12/02/2025.
//

import SwiftUI

enum TripAddressFieldsViewFocus: Hashable {
    case departure
    case arrival
}

struct TripAddressFieldsView: View {
    @Binding private var departure: String
    @Binding private var arrival: String
    @Binding private var isFocused: Bool
    @FocusState private var focusedField: TripAddressFieldsViewFocus?


    init(departure: Binding<String>, arrival: Binding<String>, isFocused: Binding<Bool>) {
        self._departure = departure
        self._arrival = arrival
        self._isFocused = isFocused
    }

    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                TextField("Départ", text: $departure)
                    .focused($focusedField, equals: .departure)
                    .padding()
                    .background(Color("InputsColor"))
                    .cornerRadius(20)

                TextField("Arrivée", text: $arrival)
                    .focused($focusedField, equals: .arrival)
                    .padding()
                    .background(Color("InputsColor"))
                    .cornerRadius(20)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            .onChange(of: focusedField) { oldValue, newValue in
                isFocused = newValue != nil
            }

            Button(action: {
                if departure.isEmpty && arrival.isEmpty {
                    return
                }
                swap(&departure, &arrival)
            }) {
                ZStack {
                    Circle()
                        .fill(Color("GotoColor"))
                        .frame(width: 44, height: 44)
                    Image("reverse")
                        .resizable()
                        .frame(width: 16, height: 28)
                }
            }
            .offset(x: 140)
            .buttonStyle(PlainButtonStyle())
        }
    }
}
