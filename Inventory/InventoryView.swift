//
//  InventoryView.swift
//  Fairway
//
//  Created by Leonardo David Arias Ruiz on 05/03/23.
//

import SwiftUI

struct InventoryView: View {
    
    @State private var selected = "Categorías"
    
    private let category = "Categorías"
    private let products = "Productos"
    private let groups = "Grupos"
    private let extras = "Extras"
    
    var body: some View {
        TabView (selection: $selected) {
            CategoriesView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.fill")
                    Text(category)
                }
                .tag(category)
            ProductsView()
                .tabItem {
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                    Text(products)
                }
                .tag(products)
            GroupsView()
                .tabItem {
                    Image(systemName: "plus.forwardslash.minus")
                    Text(groups)
                }
                .tag(groups)
            ExtrasView()
                .tabItem {
                    Image(systemName: "star")
                    Text(extras)
                }
                .tag(extras)
        }.navigationTitle(selected)
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView()
    }
}
