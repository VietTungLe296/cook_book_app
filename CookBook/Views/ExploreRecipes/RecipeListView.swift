//
//  RecipeListView.swift
//  CookBook
//
//  Created by Le Viet Tung on 01/06/2023.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject private var recipeData : RecipeData
    let category : Category
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    var body: some View {
         NavigationStack {
                List {
                    ForEach(recipes) { recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: recipe)
                        } label: {
                            Text(recipe.mainInformation.name)
                        }
                    }.listRowBackground(AppColor.background)
                }
                .listStyle(PlainListStyle())
                .navigationTitle(navigationTitle)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isPresenting = true
                        },
                               label: {
                            Image(systemName: "plus")
                        })
                    }
                }
                .sheet(isPresented: $isPresenting, content: {
                    NavigationStack {
                        ModifyRecipeView(recipe: $newRecipe)
                        .navigationTitle("Add a new recipe")
                        .toolbar(content: {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresenting = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                if(newRecipe.isValid) {
                                    Button("Add") {
                                        recipeData.add(recipe: newRecipe)
                                        isPresenting = false
                                    }
                                } 
                            }
                        })
                    }
                })
        }.environmentObject(recipeData)
    }
}


extension RecipeListView {
    private var recipes : [Recipe] {
        recipeData.recipes(for: category)
    }
    
    private var navigationTitle : String {
        "\(category.rawValue) Recipes"
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(category: .breakfast)
            .environmentObject(RecipeData())
    }
}
