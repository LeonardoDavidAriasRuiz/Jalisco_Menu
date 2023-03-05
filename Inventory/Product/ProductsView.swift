//
//  ProductsView.swift
//  Fairway
//
//  Created by Leonardo David Arias Ruiz on 05/03/23.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject private var inventory: Inventory
    var body: some View {
        VStack {
            
            List{
                ForEach(inventory.products, id: \.self) { product in
                    Text(product.name ?? "")
                }
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
