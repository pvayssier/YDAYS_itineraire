//
//  ProfileViewModel.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 05/03/2025.
//


import Foundation
import Tools
import Models
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user = User(email: "test@test.fr", firstname: "John", lastname: "Doe", disability: Disability.hearing)
    @Published var errorMessages: [UserField: String] = [:]
    @Published var isLoading: Bool = false
    
    
    func getValue(for field: UserField) -> String {
        switch field {
        case .email:
            return user.email
        case .firstname:
            return user.firstname
        case .lastname:
            return user.lastname
        case .disability:
            return user.disability.rawValue
        }
    }
    
    func validate(field: UserField, value: String) {
        switch field {
        case .email:
            if !AuthValidator.isValidEmail(value) {
                errorMessages[field] = "Le format de l'email est invalide."
            } else {
                errorMessages.removeValue(forKey: field)
            }
        case .firstname, .lastname:
            if value.trimmingCharacters(in: .whitespaces).isEmpty {
                errorMessages[field] = "Ce champ ne peut pas être vide."
            } else {
                errorMessages.removeValue(forKey: field)
            }
        default:
            errorMessages.removeValue(forKey: field)
        }
        
        objectWillChange.send()
    }

    func modify(field: UserField, newValue: String) {
        isLoading = true
        guard errorMessages[field] == nil else { return }
        switch field {
        case .email:
            user.email = newValue
            isLoading = false
        case .firstname:
            user.firstname = newValue
            isLoading = false
        case .lastname:
            user.lastname = newValue
            isLoading = false
        default: break
        }
    }
}
