//
//  RecipesListView.swift
//  CookBook
//
//  Created by Le Viet Tung on 01/06/2023.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeData : RecipeData
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()

    let viewStyle : ViewStyle
    
    var body: some View {
         NavigationStack {
                List {
                    ForEach(recipes) { recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: binding(for: recipe))
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


extension RecipesListView {
    private var recipes : [Recipe] {
        switch viewStyle {
            case let .singleCategory(category):
                return recipeData.recipes(for: category)
            case .favorites:
                return recipeData.favoriteRecipes
        }
    }
        
    private var navigationTitle : String {
        switch viewStyle {
            case let .singleCategory(category):
                return "\(category.rawValue) Recipes"
            case .favorites:
                return "Favorite Recipes"
            }
        }
        
        func binding(for recipe : Recipe) -> Binding<Recipe> {
            guard let index = recipeData.index(of: recipe) else {
                fatalError("Recipe Not Found")
            }
            
            return $recipeData.recipes[index]
        }
}

enum ViewStyle {
    case favorites
    case singleCategory(Category)
}

struct RecipesListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      RecipesListView(viewStyle: .singleCategory(.breakfast))
    }.environmentObject(RecipeData())
  }
}
