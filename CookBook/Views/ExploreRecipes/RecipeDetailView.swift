//
//  RecipeDetailView.swift
//  CookBook
//
//  Created by Le Viet Tung on 01/06/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe : Recipe
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients").foregroundColor(.blue)) {
                    ForEach(recipe.ingredients.indices,id: \.self) { index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                    }
                }.listRowBackground(AppColor.background)
                Section(header: Text("Todo List").foregroundColor(.blue))
                    {
                        ForEach(recipe.directions.indices, id: \.self) {index in
                            let direction = recipe.directions[index]
                            let description = (direction.isOptional ? ("(Optional) ") : "") + direction.description
                            HStack {
                                Text("\(index+1). ").bold()
                                Text("\(description)")
                            }
                        }
                    }.listRowBackground(AppColor.background)
            }.listStyle(PlainListStyle())
        }
        .navigationTitle(recipe.mainInformation.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    static var previews: some View {
        NavigationView {
            RecipeDetailView(recipe: recipe)
        }
    }
}
