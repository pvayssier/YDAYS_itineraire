//
//  FavoriesStack.swift
//  Frameworks
//
//  Created by Paul Vayssier on 12/02/2025.
//

import SwiftUI

struct FavoriesStack: View {
    var body: some View {
        HStack(spacing: 20) {
            Button("HOME") {}
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("ContainersColor"))
                .foregroundColor(Color("TextsColor"))
                .cornerRadius(30)

            Button("TRAVAIL") {}
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("ContainersColor"))
                .foregroundColor(Color("TextsColor"))
                .cornerRadius(30)

            Button("AUTRE") {}
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("ContainersColor"))
                .foregroundColor(Color("TextsColor"))
                .cornerRadius(30)
        }
    }
}

#Preview {
    FavoriesStack()
}
