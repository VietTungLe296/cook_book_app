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
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._ingredient = component
        self.createAction = createAction
    }
    
    var body: some View {
            Form {
                TextField("Ingredient Name",text: $ingredient.name)
                    .autocorrectionDisabled(true)
                    .listRowBackground(listBackgroundColor)
                    .foregroundColor(listTextColor)
                HStack {
                    Text("Quantity:")
                    TextField("Quantity",
                            value: ($ingredient.quantity),
                            formatter: NumberFormatter.decimal)
                    .keyboardType(.numberPad)
                }
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
                
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
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
                
                HStack {
                    Spacer()
                    Button("Save") {
                        createAction(ingredient)
                        dismiss()
                    }
                    Spacer()
                }
            }   

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
