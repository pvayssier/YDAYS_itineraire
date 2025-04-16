//
//  LayoutView.swift
//  Frameworks
//
//  Created by William Fort on 12/02/2025.
//

import SwiftUI

public struct LayoutView: View {
    public init() {}
    
    public var body: some View {
        HStack {
            Button(action: {
                print("Menu tapped")
            }) {
                Image("menu", bundle: .main)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Button(action: {
                print("Ears tapped")
            }) {
                Image("ears", bundle: .main)
                    .resizable()
                    .frame(width: 28, height: 46)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 40)
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    LayoutView()
}
