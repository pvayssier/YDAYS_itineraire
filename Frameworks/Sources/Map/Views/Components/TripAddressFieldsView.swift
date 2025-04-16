//
//  TripAddressFieldsView.swift
//  Frameworks
//
//  Created by Paul Vayssier on 12/02/2025.
//

import SwiftUI

// copilot me to find a name for this view

struct TripAddressFieldsView: View {
    @Binding private var departure: String
    @Binding private var arrival: String

    init(departure: Binding<String>, arrival: Binding<String>) {
        self._departure = departure
        self._arrival = arrival
    }

    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                TextField("Départ", text: $departure)
                    .padding()
                    .background(Color("InputsColor"))
                    .cornerRadius(20)

                TextField("Arrivée", text: $arrival)
                    .padding()
                    .background(Color("InputsColor"))
                    .cornerRadius(20)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)

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
