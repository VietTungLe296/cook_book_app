//
//  ModifyDirectionView.swift
//  CookBook
//
//  Created by Le Viet Tung on 10/06/2023.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    @Binding var direction : Direction
    let createAction : (Direction) -> Void
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
      }
    
    var body: some View {
        Form {
            Section(header: Text("Description")) {
                TextEditor(text: $direction.description)
                .autocorrectionDisabled(true)
                .frame(height: 100)
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
            
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
            
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    dismiss()
                }
                Spacer()
            }
        }
        
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
  @State static var emptyDirection = Direction(description: "", isOptional: false)
  static var previews: some View {
    NavigationView {
      ModifyDirectionView(component: $emptyDirection) { _ in return }
            .navigationTitle("Add Description")
    }
  }
}
