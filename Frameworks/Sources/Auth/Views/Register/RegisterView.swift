//
//  RegisterView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI
import Map
import UI

public struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()

    public init() {}

    public var body: some View {
        NavigationStack {
            ZStack {
                BackgroundComponent()
                
                VStack {
                    switch viewModel.currentStep {
                    case .selectDisability:
                        DisabilitySelectionView(viewModel: viewModel)
                    case .personalInfo:
                        PersonalInfoView(viewModel: viewModel)
                    case .credentials:
                        CredentialsView(viewModel: viewModel)
                    case .recap:
                        RecapView(viewModel: viewModel)
                    }
                }
                .navigationBarHidden(true)
                .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                    MapView()
                }
            }
        }
    }
}
#Preview {
    RegisterView()
}

