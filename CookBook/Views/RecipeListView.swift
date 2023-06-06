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
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    
    var body: some View {
         NavigationStack {
                List {
                    ForEach(recipes) { recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: recipe)
                        } label: {
                            Text(recipe.mainInformation.name)
                        }
                    }.listRowBackground(listBackgroundColor)
                }
                .listStyle(PlainListStyle())
                .navigationTitle(navigationTitle)
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
