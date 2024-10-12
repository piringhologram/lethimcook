//
//  Model.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//

import Foundation
import SwiftUI

@Observable public class Model {
    public var recipes: [Recipe]
    
    public init(recipes: [Recipe] = []) {
        self.recipes = recipes
    }
    
    /// Get a `Recipe` for a specific ID
    ///
    public func recipe(_ id: Recipe.ID?) -> Recipe? {
        recipes.first(where: { $0.id == id })
    }
    
    /// Checks whether a `Recipe` for a specific ID already exists
    public func recipeExists(_ id: Recipe.ID?) -> Bool {
        recipes.contains(where: { $0.id == id })
    }
    
    /// Save a `Recipe`
    public func save(_ recipe: Recipe) async throws {
        if recipe.title.isEmpty {
            throw RecipeError.emptyName
        }
        try? await Task.sleep(nanoseconds: 500_000_000)
        DispatchQueue.main.async {
            var newRecipe = recipe
            // Assign an ID if it is a newly created recipe
            if newRecipe.id == nil {
                newRecipe.id = UUID()
            }
            
            self.recipes.removeAll(where: { $0.id == newRecipe.id })
            self.recipes.append(newRecipe)
            self.recipes.sort()
        }
    }
    
    public func delete(recipeId id: Recipe.ID) async {
        try? await Task.sleep(nanoseconds: 500_000_000)
        DispatchQueue.main.async {
            self.recipes.removeAll(where: { $0.id == id })
        }
    }
}

enum RecipeError: Error {
    case emptyName
    case emptyIngredients
    case emptyInstructions
}
