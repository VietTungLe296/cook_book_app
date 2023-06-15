//
//  MainTabView.swift
//  CookBook
//
//  Created by Le Viet Tung on 11/06/2023.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var recipeData = RecipeData()
    
    var body: some View {
        TabView {
            RecipeCategoryGridView()
            .tabItem {
                Label("Recipes", systemImage: "list.dash")
            }
            
            NavigationStack {
                RecipesListView(viewStyle: .favorites)
            }
            .tabItem {
                Label("Favorites",systemImage: "heart.fill")
            }
            
            SettingsView()
            .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }
        .environmentObject(recipeData)
        .onAppear {
          recipeData.loadRecipes()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
