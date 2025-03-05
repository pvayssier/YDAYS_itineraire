//
//  User.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 05/03/2025.
//

import Foundation

public struct User: Identifiable {
    public let id: UUID
    public var email: String
    public var firstname: String
    public var lastname: String
    public var disability: Disability
    
    public init(id: UUID = UUID(), email: String, firstname: String, lastname: String, disability: Disability) {
        self.id = id
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.disability = disability
    }
}

