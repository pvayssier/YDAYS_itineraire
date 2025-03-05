//
//  ProfileView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 05/03/2025.
//


import SwiftUI
import Map
import UI
import Models

public struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    
    public init() {}

    public var body: some View {
        NavigationStack() {
            ZStack {
                BackgroundComponent()
                
                VStack {
                    CustomProfileTextField(field: .email, viewModel: viewModel).padding(.bottom, 24)
                    CustomProfileTextField(field: .lastname, viewModel: viewModel).padding(.bottom, 24)
                    CustomProfileTextField(field: .firstname, viewModel: viewModel).padding(.bottom, 24)
                    CustomProfileTextField(field: .disability, viewModel: viewModel).padding(.bottom, 24)
                }
                .padding(.horizontal, 45)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ProfileView()
}
