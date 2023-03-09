//
//  ProductsView.swift
//  Fairway
//
//  Created by Leonardo David Arias Ruiz on 05/03/23.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject private var inventory: Inventory
    @State private var product = Product()
    var body: some View {
        VStack {
            
            newProductArea
            productsList
            
        }.background(Color("background"))
    }
    
    var newProductArea: some View {
        VStack {
            Titles().product
            HStack {
                TextFieldText(text: $product.name)
                TextFieldText(text: $product.printer)
                TextFieldText(text: $product.price1)
                TextFieldText(text: $product.price2)
                ChooseColor(color: $product.color)
            }
            Button(action: createProduct, label: {SaveButton()})
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.white)
        .cornerRadius(10)
        .padding(20)
    }
    
    var productsList: some View {
        List{
            ForEach(inventory.products, id: \.self) { product in
                HStack {
                    Text(product.name ?? "")
                }
            }
            .onDelete(perform: deleteProduct)
        }
    }
    
    func createProduct() {
        CoreDataManager().createProduct(product: product)
        product = Product()
        inventory.products = CoreDataManager().allProducts()
    }
    
    func deleteProduct(indexSet: IndexSet) {
        indexSet.forEach { index in
            CoreDataManager().deleteProduct(product: inventory.products[index])
            inventory.products = CoreDataManager().allProducts()
        }
    }
}

struct Product {
    var name: String = ""
    var printer: String = ""
    var price1: String = "0.00"
    var price2: String = "0.00"
    var color: Color = Color.green
}

