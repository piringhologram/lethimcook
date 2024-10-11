//
//  MockModel.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//

import Foundation

public class MockModel: Model {
    public convenience init() {
        let recipeOne = Recipe(id: UUID(),
                               title: "Fried Egg",
                               ingredients: "Egg and Stuff",
                               instructons: "Add egg then cook",
                               image: "recipe1")
        let recipeTwo = Recipe(id: UUID(),
                               title: "Boiled Egg",
                               ingredients: "Egg and Pepper",
                               instructons: "Add egg then boil",
                               image: "recipe2")
        let recipeThree = Recipe(id: UUID(),
                                 title: "Spaghetti with some fancy truffle",
                                 ingredients: "Salt and Egg",
                                 instructons: "Add egg then sun",
                                 image: "recipe3")
        
        let recipes = [recipeOne, recipeTwo, recipeThree]
        
        self.init(recipes: recipes)
    }
}
