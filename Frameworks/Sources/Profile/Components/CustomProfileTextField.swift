//
//  CustomProfileTextField.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 05/03/2025.
//

import SwiftUI
import Models

public struct CustomProfileTextField: View {
    var field: UserField
    @State private var isEditing: Bool = false
    @State private var tempText: String = ""
    @State private var showConfirmation: Bool = false
    @ObservedObject var viewModel: ProfileViewModel


    init(field: UserField,  viewModel: ProfileViewModel) {
        self.field = field
        self.viewModel = viewModel
        self._tempText = State(initialValue: viewModel.getValue(for: field))
    }


    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(getLabel(for: field))
                .font(.headline)
                .foregroundColor(.gray)

            ZStack(alignment: .trailing) {
                if isEditing && field != .disability {
                    TextField(getLabel(for: field), text: $tempText)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .foregroundColor(Color("Beige", bundle: .main))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)
                        .onChange(of: tempText) {
                            viewModel.validate(field: field, value: tempText)
                        }
                    
                } else {
                    Text(viewModel.getValue(for: field))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .foregroundColor(Color("Beige", bundle: .main))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)
                        
                }
                
                let isDisabled = viewModel.errorMessages[field] != nil

                if field != .disability  {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                                .padding(.trailing, 8)
                        } else {
                            Button(action: {
                                if isEditing {
                                    showConfirmation = true
                                } else {
                                    tempText = viewModel.getValue(for: field)
                                    isEditing = true
                                }
                            }) {
                                Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil")
                                    .foregroundColor(isDisabled ? .gray : Color("Beige", bundle: .main))
                                    .padding(.trailing, 8)
                            }
                            .disabled(isDisabled)
                        }
                    }
                }
            }
            
            if let errorMessage = viewModel.errorMessages[field] {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.top, 2)
            }
        }
        .padding(.horizontal)
        .confirmationDialog("Êtes-vous sûr de vouloir modifier cette information ?", isPresented: $showConfirmation, titleVisibility: .visible) {
                    Button("Confirmer", role: .destructive) {
                        viewModel.modify(field: field, newValue: tempText)
                        isEditing = false
                    }
                    Button("Annuler", role: .cancel) {
                        showConfirmation = false
                        viewModel.isLoading = false
                        isEditing = false
                    }
                }
    }
    
    private func getLabel(for field: UserField) -> String {
        switch field {
        case .email:
            return "Email"
        case .firstname:
            return "Prénom"
        case .lastname:
            return "Nom"
        case .disability:
            return "Handicap"
        }
    }
}

#Preview {
    CustomProfileTextField(field: .email, viewModel: ProfileViewModel())
}
