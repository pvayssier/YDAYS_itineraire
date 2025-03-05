//
//  CredentialsView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//


import SwiftUI
import UI

public struct CredentialsView: View {
    @ObservedObject var viewModel: RegisterViewModel

    public var body: some View {
            VStack {
                Spacer()
                
                CustomAuthTextField(
                    text : $viewModel.email,
                    label: "Email"
                ).padding(.bottom, 24)
                
                CustomAuthTextField(text : $viewModel.password, label: "Mot de passe", isSecureField: true).padding(.bottom, 24)
                
                CustomAuthTextField(text : $viewModel.confirmPassword, label: "Confirmer le mot de passe", isSecureField: true)
                
                Spacer()
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                }
                ButtonComponent(title: "Suivant") {
                    viewModel.validateCredentials()
                    if (viewModel.isCredentialsValid){
                        viewModel.nextStep()
                    }
                }.disabled(viewModel.isCredentialsValid)
            }.padding(.horizontal, 45)
    }
}

#Preview {
    CredentialsView(viewModel: RegisterViewModel())
}

