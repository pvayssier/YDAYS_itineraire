//
//  RecapView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI
import UI

public struct RecapView: View {
    @ObservedObject var viewModel: RegisterViewModel

    public var body: some View {
        VStack (spacing : 30){
            Spacer()
            
            Text("RÉCAPITULATIF")
                .font(.system(size: 32))
                .foregroundColor(Color("DarkBlue", bundle: .main))
                .padding(.bottom, 54)
            
            TextDisplayComponent(label: "Nom", text: viewModel.lastName)
            TextDisplayComponent(label: "Prénom", text: viewModel.firstName)
            TextDisplayComponent(label: "Email", text: viewModel.email)
            TextDisplayComponent(label: "Handicap", text: viewModel.disability.rawValue)
       
            
            Spacer()
            
            ButtonComponent(title: "S'inscrire") {
                viewModel.register()
            }
        }
        .padding(.horizontal, 45)
    }
}

#Preview {
    RecapView(viewModel: RegisterViewModel())
}








