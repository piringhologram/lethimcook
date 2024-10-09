//
//  MockModel.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//

import Foundation

public class MockModel: Model {
    public convenience init() {
        let recipeOne = Recipe(id: UUID(), title: "Fried Egg", ingredients: "Egg and Stuff", instructons: "Add egg then cook")
        let recipeTwo = Recipe(id: UUID(), title: "Boiled Egg", ingredients: "Egg and Pepper", instructons: "Add egg then boil")
        let recipeThree = Recipe(id: UUID(), title: "Sunny Side Egg with some fancy stuff", ingredients: "Salt and Egg", instructons: "Add egg then sun")
        
        let recipes = [recipeOne, recipeTwo, recipeThree]
        
        self.init(recipes: recipes)
    }
}
