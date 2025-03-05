//
//  BackgroundComponent.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 05/03/2025.
//


import SwiftUI

public struct BackgroundComponent: View {
    public init() {}

    public var body: some View {
        Color(UIColor(red: 1.0, green: 0.97, blue: 0.94, alpha: 1.0))
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 400, height: 300)
                    .offset(x: -100, y: -400)
            )
    }
}

// MARK: - Preview
#Preview {
    BackgroundComponent()
}

