//
//  Recipe.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//
import Foundation
import SwiftUI

public struct Recipe {
    public var id: UUID?
    public var title: String
    public var ingredients: String
    public var instructions: String
    public var isFavorite: Bool
    public var timeAndDate: Date
    public var image: String
    
    /// - Parameters:
    ///   - id:
    ///   - title: The name of the recipe
    ///   - ingredients: Ingredients of the recipe
    ///   - instructions: Instructions on how to make the recipe
    ///   - image : personal image corresponding to the recipe
    ///  - Other attributes:
    ///    - isFavorite: marks, whether a recipe is marks as the user favorite or not. Default is false
    ///    - timeAndDate: The date this recipe is created
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
// Used so that object can be identifiable and retrivied by specific ID
extension Recipe: Identifiable { }

// Used because navigationLink needs their components to be Hashable
extension Recipe: Hashable { }

extension Recipe: Codable { }

extension Recipe: Comparable {
    public static func < ( a: Recipe, b: Recipe ) -> Bool {
        a.timeAndDate < b.timeAndDate
    }
}
