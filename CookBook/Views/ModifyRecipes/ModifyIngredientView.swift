//
//  ModifyIngredients.swift
//  CookBook
//
//  Created by Le Viet Tung on 07/06/2023.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
    @Binding var ingredient : Ingredient
    let createAction : (Ingredient) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._ingredient = component
        self.createAction = createAction
    }
    
    var body: some View {
            Form {
                TextField("Ingredient Name",text: $ingredient.name)
                    .autocorrectionDisabled(true)
                    
                HStack {
                    Text("Quantity:")
                    TextField("Quantity",
                            value: ($ingredient.quantity),
                            formatter: NumberFormatter.decimal)
                    .keyboardType(.numberPad)
                }

                Picker(selection : $ingredient.unit, label:
                        HStack {
                    Text("Unit")
                    Spacer()
                }) {
                    ForEach(Unit.allCases, id: \.self) {unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                HStack {
                    Spacer()
                    Button("Save") {
                        createAction(ingredient)
                        dismiss()
                    }
                    Spacer()
                }
            }
            .foregroundColor(AppColor.foreground)
    }
}

extension NumberFormatter {
    static var decimal : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

struct ModifyIngredientView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    
    static var previews: some View {
        NavigationView {
           ModifyIngredientView(component: $recipe.ingredients[0]) { ingredient in
                print(ingredient)
            }.navigationTitle("Add Ingredient")
        }
    }
}
