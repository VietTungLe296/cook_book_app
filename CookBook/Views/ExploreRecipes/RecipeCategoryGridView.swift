//
//  RecipeCategoryGridView.swift
//  CookBook
//
//  Created by Le Viet Tung on 05/06/2023.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    @StateObject private var recipeData = RecipeData()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                let columns = [GridItem(), GridItem()]
                LazyVGrid(columns: columns, content: {
                    ForEach(Category.allCases,id: \.self) {category in
                        NavigationLink {
                           RecipeListView(category: category)
                        } label: {
                            CategoryView(category : category)
                        }
                    }
                })
            }
            .navigationTitle("Categories")
        }.environmentObject(recipeData)
    }
}


struct CategoryView : View {
    let category : Category
    
    var body : some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 190, height: 180)
                .clipped()
                .opacity(0.60)
            Text(category.rawValue)
                .font(.title)
                .foregroundColor(.indigo)
                .italic()
            
        }
    }
}

struct RecipeCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryGridView()
    }
}
