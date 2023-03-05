//
//  ProductView.swift
//  Fairway
//
//  Created by Felipe Arias on 06/12/22.
//

import SwiftUI

struct UpdateProductView: View {
    @State private var newProduct: NewProduct = NewProduct()
    @State private var selectedCategory: CategoryProduct = CategoryProduct()
    
    let coreDM: CoreDataManager = CoreDataManager()
    let product: Product
    
    @Binding var productSelected: Bool
    @Binding var products: [Product]
    @Binding var categories: [CategoryProduct]
    @State var groupExtras = CoreDataManager().allGroups()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    TitleList(title: "Nombre")
                    TitleList(title: "Impresora")
                    TitleList(title: "Regular")
                    TitleList(title: "Door Dash")
                    TitleList(title: "Grubhub")
                    TitleListCenter(title: "Color")
                }.titleNewItem()
                VStack {
                    HStack {
                        TextFieldText(text: $newProduct.name)
                        TextFieldText(text: $newProduct.printer)
                        TextFieldNumber(text: $newProduct.re)
                        TextFieldNumber(text: $newProduct.dd)
                        TextFieldNumber(text: $newProduct.gh)
                        ChooseColor(color: $newProduct.color)
                    }
                    HStack {
                        CategoryPicker(categories: $categories, selectedCategory: $newProduct.category)
                        VisibleToggle(visible: $newProduct.visible)
                        Button(action: updateProduct, label: {
                            SaveButton()}
                        )
                    }
                }.whiteRecatangleRounded()
            }
            AllGroups(groupExtras: $groupExtras)
        }.background(Color("background"))
        .navigationTitle("\(newProduct.name)")
        .onAppear(perform: onApper)
    }
    
    private func onApper() {
        newProduct.name = product.name ?? "Error"
        newProduct.printer = product.printer ?? "Error"
        newProduct.dd = String(product.dd)
        newProduct.gh = String(product.gh)
        newProduct.re = String(product.re)
        newProduct.visible = product.visible
        newProduct.color = Color(hex: product.color ?? "#32CD5A")
        categories = coreDM.allCategories()
        for categoryProduct in categories {
            if (categoryProduct.id == product.idCategory) {
                newProduct.category = categoryProduct
            }
        }
    }
    
    private func updateProduct() {
        withAnimation {
            product.name = newProduct.name
            product.printer = newProduct.printer
            product.dd = Double(newProduct.dd) ?? 0.00
            product.gh = Double(newProduct.gh) ?? 0.00
            product.re = Double(newProduct.re) ?? 0.00
            product.visible = newProduct.visible
            product.idCategory = newProduct.category.id
            product.color = newProduct.color.hex
            
            coreDM.update()
            products = coreDM.allProducts()
            productSelected = productSelected ? false : true
        }
    }
}

