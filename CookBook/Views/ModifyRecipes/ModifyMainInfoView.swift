//
//  ModifyMainInfoView.swift
//  CookBook
//
//  Created by Le Viet Tung on 07/06/2023.
//

import SwiftUI

struct ModifyMainInfoView: View {
    @Binding var mainInformation : MainInformation
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
            Form {
                Section(header: Text("Recipe Name")) {
                    TextField("Recipe Name", text: $mainInformation.name)
                    .autocorrectionDisabled(true)
                }
                .listRowBackground(listBackgroundColor)
                
                Section(header: Text("Author Name")) {
                    TextField("Author", text: $mainInformation.author)
                    .autocorrectionDisabled(true)
                }
                .listRowBackground(listBackgroundColor)
             
                Section(header: Text("Description")) {
                    TextEditor(text: $mainInformation.description)
                        .frame(height: 100)
                        .autocorrectionDisabled(true)
                }
                .listRowBackground(listBackgroundColor)
                
                Picker(selection: $mainInformation.category,
                       label: HStack {
                            Text("Category")
                            Spacer()
                }) {
                    ForEach(Category.allCases, id: \.self) {category in
                        Text(category.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .listRowBackground(listBackgroundColor)
            }
            .foregroundColor(listTextColor)
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
