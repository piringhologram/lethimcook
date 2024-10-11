//
//  Recipe.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//
import Foundation
import SwiftUI

// Identifiable : Used so that object can be identifiable and retrivied by specific ID
// Hashable : Used because navigationLink needs their components to be Hashable
public struct Recipe: Identifiable, Hashable, Codable {
    public var id: UUID?
    public var title: String
    public var ingredients: String
    public var instructions: String
    public var isFavorite: Bool
    public var timeAndDate: Date
    public var image: String
    
    public init(id: UUID? = nil, title: String, ingredients: String, instructons: String, image: String) {
        self.id = id
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructons
        self.isFavorite = false
        self.timeAndDate = Date()
        self.image = image
    }
}

extension Recipe: Comparable {
    public static func < ( a: Recipe, b: Recipe ) -> Bool {
        a.timeAndDate < b.timeAndDate
    }
}
