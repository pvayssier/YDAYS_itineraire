//
//  ItinerarySheetView.swift
//  Frameworks
//
//  Created by William Fort on 12/02/2025.
//

import Combine
import SwiftUI
import Tools

@propertyWrapper
public class BindableBis<Value> {
    @Published private var value: Value

    public var wrappedValue: Value {
        get { value }
        set { value = newValue }
    }

    public var projectedValue: Published<Value>.Publisher {
        $value
    }

    public var publisher: Published<Value> { _value }

    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }

    public func update(to newValue: Value) {
        self.value = newValue
    }
}


public struct ItinerarySheetView: View {

    @BindableBis private var isHeightLocked: Bool = false
    @BindableBis private var sheetState: DraggableSheetViewModel.SheetState = .minimized

    @State private var isSheetPresented: Bool = true
    @State private var departure: String = ""
    @State private var arrival: String = ""
    @State private var showRouteBlock: Bool = false // Gère l'affichage du bloc trajet
    @State private var sheetDetent: PresentationDetent = .fraction(0.5) // Taille du Bottom Sheet
    @State private var isTripAddressFieldsFocused: Bool = false

    // Vérifie si les deux champs sont remplis
    private var isFormValid: Bool {
        !departure.isEmpty && !arrival.isEmpty
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
                .padding(.bottom, 160)
                .padding(.trailing, 20)
            }
        }
        .draggableSheet(isPresented: $isSheetPresented,
                        state: _sheetState.publisher,
                        isHeightLocked: _isHeightLocked.publisher) {
                VStack() {
                    // Section des boutons "Home", "Travail", "Autre"
                    FavoriesStack()
                    // Inputs "Départ" et "Arrivée" avec bouton d'inversion
                    TripAddressFieldsView(departure: $departure,
                                          arrival: $arrival,
                                          isFocused: $isTripAddressFieldsFocused)
                    .onChange(of: isTripAddressFieldsFocused) { oldValue, newValue in
                        if oldValue != newValue && newValue {
                            _sheetState.update(to: .custom(600))
                        }
                        _isHeightLocked.update(to: newValue)
                    }
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
                            _sheetState.update(to: .fullScreen)
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
            .padding()
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ItinerarySheetView()
}
