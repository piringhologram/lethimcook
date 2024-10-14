//
//  MockModel.swift
//  lethimcook
//
//  Created by ipraktikum on 09.10.24.
//

import Foundation
import UIKit

let recipe1 = "recipe1"
let recipe2 = "recipe2"
let recipe3 = "recipe3"
let imageData1 = UIImage(named: recipe1)?.pngData()
let imageData2 = UIImage(named: recipe2)?.pngData()
let imageData3 = UIImage(named: recipe3)?.pngData()

public class MockModel: Model {
    public convenience init() {
        let recipeOne = Recipe(id: UUID(),
                               title: "Fried Egg",
                               ingredients: "Egg and Stuff",
                               instructons: "Add egg then cook",
                               image: "recipe1",
                               customImageData: imageData1)
        let recipeTwo = Recipe(id: UUID(),
                               title: "Boiled Egg",
                               ingredients: "Egg and Pepper",
                               instructons: "Add egg then boil",
                               image: "recipe2",
                               customImageData: imageData2)
        let recipeThree = Recipe(id: UUID(),
                                 title: "Spaghetti with some fancy shrooms",
                                 ingredients: "Egg and Stuff\nPasta\nSome good cheese\nSalt and Pepper",
                                 instructons: "Add egg then sun",
                                 image: "recipe3",
                                 customImageData: imageData3)
        
        let recipes = [recipeOne, recipeTwo, recipeThree]
        
        self.init(recipes: recipes)
    }
}
