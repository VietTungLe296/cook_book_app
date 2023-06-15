//
//  RecipeData.swift
//  CookBook
//
//  Created by Le Viet Tung on 01/06/2023.
//

import Foundation

class RecipeData : ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    var favoriteRecipes : [Recipe] {
        recipes.filter {$0.isFavorite}
    }
    
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
            saveRecipes()
        }
    }
    
    func index(of recipe: Recipe) -> Int? {
        return recipes.firstIndex {$0.id == recipe.id}
    }
    
    // Persistence
    private var recipesFileURL: URL {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                in: .userDomainMask,
                                                                appropriateFor: nil,
                                                                create: true)
            return documentDirectory.appendingPathComponent("recipeData")
        }
        catch {
            fatalError("An error occurred while getting the url: \(error)")
        }
    }
    
    func saveRecipes() {
        do {
            let encodedData = try JSONEncoder().encode(recipes)
            try encodedData.write(to: recipesFileURL)
        }
        catch {
            fatalError("An error occurred while saving recipes: \(error)")
        }
    }
    
    func loadRecipes() {
        guard let data = try? Data(contentsOf: recipesFileURL) else {return}
        
        do {
            recipes = try JSONDecoder().decode([Recipe].self, from: data)
        }
        catch {
            fatalError("An error occurred while loading recipes: \(error)")
        }
    }
}
