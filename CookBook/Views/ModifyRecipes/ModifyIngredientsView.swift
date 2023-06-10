//
//  ModifyIngredientsView.swift
//  CookBook
//
//  Created by Le Viet Tung on 07/06/2023.
//

import SwiftUI

struct ModifyIngredientsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    var body: some View {
        VStack {
            let addIngredientView = ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                ingredients.append(ingredient)
                newIngredient = Ingredient()
            }
            .navigationTitle("Add Ingredient")

            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient", destination: addIngredientView)
                Spacer()
            } else {
                HStack {
                    Text("Ingredients")
                        .font(.title)
                        .padding()
                    Spacer()
                }
                
                List {
                    ForEach(ingredients.indices, id: \.self) {index in
                        Text(ingredients[index].description)
                    }
                    NavigationLink("Add another ingredient", destination: addIngredientView)
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[1]
    @State static var emptyIngredients = [Ingredient]()
    
    static var previews: some View {
        NavigationView {
            ModifyIngredientsView(ingredients: $recipe.ingredients)
        }
        NavigationView {
            ModifyIngredientsView(ingredients: $emptyIngredients)
        }
    }
}
