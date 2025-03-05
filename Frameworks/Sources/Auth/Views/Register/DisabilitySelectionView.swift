//
//  DisabilitySelectionView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI
import Models
import Tools
import UI

public struct DisabilitySelectionView: View {
    @ObservedObject var viewModel: RegisterViewModel

    public var body: some View {
        VStack {
            Spacer()
            
            Text("HANDICAP")
                .font(.system(size: 32))
                .foregroundColor(Color("DarkBlue", bundle: .main))
                .padding(.bottom, 54)
            
            HStack{
                ForEach(Disability.allCases, id: \.self) { disability in
                    Button(action: { viewModel.disability = disability }) {
                        DisabilityIcon(title: disability.rawValue, icon: getDisabilityIcon(for: disability))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(viewModel.disability == disability ? Color("DarkBlue", bundle: .main) : Color.clear, lineWidth: 2)
                    )
                }
            }
            
            Spacer()

            ButtonComponent(title: "Suivant") {
                viewModel.nextStep()
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    DisabilitySelectionView(viewModel: RegisterViewModel())
}

