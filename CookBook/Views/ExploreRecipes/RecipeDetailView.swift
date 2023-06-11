//
//  RecipeDetailView.swift
//  CookBook
//
//  Created by Le Viet Tung on 01/06/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe : Recipe
    @State private var isPresenting = false
    
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps : Bool = false
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.system(size: 20))
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.system(size: 20))
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")
                                .font(.system(size: 20))
                                .foregroundColor(.blue)) {
                    ForEach(recipe.ingredients.indices,id: \.self) { index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                    }
                }.listRowBackground(listBackgroundColor)
                Section(header: Text("Todo List")
                                .font(.system(size: 20))
                                .foregroundColor(.blue)) {
                                    ForEach(recipe.directions.indices, id: \.self) {index in
                                        let direction = recipe.directions[index]
                                        if direction.isOptional && hideOptionalSteps {
                                            EmptyView()
                                        } else {
                                            HStack {
                                                let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                                                Text("\(index + 1). ").bold()
                                                Text("\(direction.isOptional ? "(Optional) " : "")\(direction.description)")
                                            }
                                        }
                                    }
                    }.listRowBackground(listBackgroundColor)
            }
            .listStyle(PlainListStyle())
            .foregroundColor(listTextColor)
        }
        .navigationTitle(recipe.mainInformation.name)
        .toolbar {
            ToolbarItem {
                HStack {
                    Button("Edit") {
                        isPresenting = true
                    }
                    
                    Button(action : {
                        recipe.isFavorite.toggle()
                    }) {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    }
                }
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationStack {
                ModifyRecipeView(recipe: $recipe)
                    .navigationTitle("Edit Recipe")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                                Button("Save") {
                                    isPresenting = false
                                }
                            }
                        }
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    static var previews: some View {
        NavigationView {
            RecipeDetailView(recipe: $recipe)
        }
    }
}
