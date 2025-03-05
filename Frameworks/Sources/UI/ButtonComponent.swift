//
//  ButtonComponent.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 05/03/2025.
//

import SwiftUI

public struct ButtonComponent: View {
    var title: String
    var action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 233, maxHeight: 47)
                .background(Color("Beige", bundle: .main))
                .cornerRadius(30)
        }
    }
}

#Preview {
    ButtonComponent(title: "Se connecter") {
        print("Bouton cliqué !")
    }
}


