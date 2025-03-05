//
//  PersonalInfoView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI
import UI

public struct PersonalInfoView: View {
    @ObservedObject var viewModel: RegisterViewModel

    public var body: some View {
        VStack {
            Spacer()
            
            CustomAuthTextField(
                text : $viewModel.lastName,
                label: "Nom"
            ).padding(.bottom, 24)
            
            CustomAuthTextField(text : $viewModel.firstName, label: "Prénom")
            
            Spacer()
            
            ButtonComponent(title: "Suivant") {
                viewModel.nextStep()
            }
        }
        .padding(.horizontal, 45)
    }
}

#Preview {
    PersonalInfoView(viewModel: RegisterViewModel())
}
