//
//  LoginView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI
import Map
import UI

public struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    public init() {}

    public var body: some View {
        NavigationStack() {
            ZStack {
                BackgroundComponent()
                
                VStack {
                    Spacer()
                    
                    CustomAuthTextField(text: $viewModel.email, label: "Email").padding(.bottom, 24)
                    CustomAuthTextField(text: $viewModel.password, label : "Mot de passe", isSecureField: true)
                    
                    Spacer()
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage).foregroundColor(.red)
                    }
                    ButtonComponent(title: "Se connecter") {
                        viewModel.login()
                    }
                }
                .padding(.horizontal, 45)
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                MapView()
            }
        }
    }
}

#Preview {
    LoginView()
}
