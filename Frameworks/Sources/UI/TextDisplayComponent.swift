//
//  TextDisplayComponent.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 05/03/2025.
//

import SwiftUI

public struct TextDisplayComponent: View {
    var label: String
    var text: String
    
    public init(label: String, text: String) {
        self.label = label
        self.text = text
    }

    public var body: some View {
        VStack (alignment: HorizontalAlignment.leading, spacing: 6){
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)

            Text(text)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .foregroundColor(Color("Beige", bundle: .main))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)
            
        }
    }
}

#Preview {
    TextDisplayComponent(label: "Nom Prénom", text: "John Doe")
}
