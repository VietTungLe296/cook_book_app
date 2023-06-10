//
//  ModifyMainInfoView.swift
//  CookBook
//
//  Created by Le Viet Tung on 07/06/2023.
//

import SwiftUI

struct ModifyMainInfoView: View {
    @Binding var mainInformation : MainInformation
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformation.name)
                .listRowBackground(AppColor.background)
            
            TextField("Author", text: $mainInformation.author)
                .listRowBackground(AppColor.background)
            
            Section(header: Text("Description")) {
                TextEditor(text: $mainInformation.description)
                .listRowBackground(AppColor.background)
            }
            
            Picker(selection: $mainInformation.category,
                   label: HStack {
                        Text("Category")
                        Spacer()
            }) {
                ForEach(Category.allCases, id: \.self) {category in
                    Text(category.rawValue)
                }
            }
            .listRowBackground(AppColor.background)
            .pickerStyle(MenuPickerStyle())
        }
        .foregroundColor(AppColor.foreground)
    }
}


struct ModifyMainInfoView_Previews: PreviewProvider {
    @State static var mainInformation = MainInformation(name: "Test Name",
                                                         description: "Test Description",
                                                         author: "Test Author",
                                                         category: .breakfast)
     @State static var emptyInformation = MainInformation(name: "", description: "", author: "", category: .breakfast)
         
     static var previews: some View {
         ModifyMainInfoView(mainInformation: $mainInformation)
         ModifyMainInfoView(mainInformation: $emptyInformation)
     }
}
