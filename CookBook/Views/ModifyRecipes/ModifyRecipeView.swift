//
//  ModifyRecipeView.swift
//  CookBook
//
//  Created by Le Viet Tung on 06/06/2023.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe : Recipe
    
    @State private var selection = Selection.main
    
    var body : some View {
        VStack {
            Picker("Select recipe component", selection : $selection) {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            switch selection {
            case .main:
                ModifyMainInfoView(mainInformation: $recipe.mainInformation)
            case .ingredients:
                ModifyIngredientsView(ingredients: $recipe.ingredients)
            case .directions:
                Text("Directions Editor")
            }
            
            Spacer()
        }
        .navigationTitle("Add New Recipe")
    }
}

enum Selection {
    case main, ingredients, directions
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe()
    
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
