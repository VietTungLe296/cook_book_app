//
//  RecipeData.swift
//  CookBook
//
//  Created by Le Viet Tung on 01/06/2023.
//

import Foundation

class RecipeData : ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    func recipes(for category: Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        return filteredRecipes
    }
}
