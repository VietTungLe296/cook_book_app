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
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
      }
    
    var body: some View {
        Form {
            TextField("Direction Description",text: $direction.description)
              
            Toggle("Optional", isOn: $direction.isOptional)
            
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    dismiss()
                }
                Spacer()
            }
        }
        .foregroundColor(AppColor.foreground)
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
