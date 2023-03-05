//
//  CategorysView.swift
//  Menu
//
//  Created by David Arias on 10/09/22.
//

import SwiftUI

struct CategoriesView: View {
    let coreDM: CoreDataManager
    @Binding var selectedCategory: CDCategory
    
    var body: some View {
        List {
            ForEach(coreDM.allCategories()){ category in
                Button(action: {selectedCategory = category}, label: {
                    Text("\(category.name!)")}
                ).bold().foregroundColor(Color(hex: category.color ?? "#32CD5A"))
            }
        }
    }
}
