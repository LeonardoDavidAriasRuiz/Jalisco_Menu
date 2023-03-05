//
//  InventoryView.swift
//  Fairway
//
//  Created by Leonardo David Arias Ruiz on 05/03/23.
//

import SwiftUI

struct InventoryView: View {
    var body: some View {
        TabView {
            AllCategoriesView()
                .tabItem {
                    Text("Categorías")
                    
                }
            ProductsView()
                .tabItem {
                    Text("Productos")
                    
                }
            AllCategoriesView()
                .tabItem {
                    Text("Grupos")
                    
                }
            AllCategoriesView()
                .tabItem {
                    Text("Extras")
                    
                }
        }.toolbar {
            Menu {
                Text("Productos")
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView()
    }
}
