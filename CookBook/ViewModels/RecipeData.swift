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
    
    func add(recipe:  Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
        }
    }
    
    func index(of recipe: Recipe) -> Int? {
        return recipes.firstIndex {$0.id == recipe.id}
    }
}
