//
//  ProductView.swift
//  Fairway
//
//  Created by Felipe Arias on 06/12/22.
//

import SwiftUI

struct UpdateProductView: View {
    @State private var newProduct: Product = Product()
    @State private var selectedCategory: CDCategory = CDCategory()
    
    let coreDM: CoreDataManager = CoreDataManager()
    let product: CDProduct
    
    @Binding var productSelected: Bool
    @Binding var products: [CDProduct]
    @Binding var categories: [CDCategory]
    @State var groups = CoreDataManager().allGroups()
    
    var body: some View {
        VStack {
//            VStack {
//                HStack {
//                    TitleList(title: "Nombre")
//                    TitleList(title: "Impresora")
//                    TitleList(title: "Regular")
//                    TitleList(title: "Door Dash")
//                    TitleList(title: "Grubhub")
//                    TitleListCenter(title: "Color")
//                }.titleNewItem()
//                VStack {
//                    HStack {
//                        TextFieldText(text: $newProduct.name)
//                        TextFieldText(text: $newProduct.printer)
//                        TextFieldNumber(text: $newProduct.re)
//                        TextFieldNumber(text: $newProduct.dd)
//                        TextFieldNumber(text: $newProduct.gh)
//                        ChooseColor(color: $newProduct.color)
//                    }
//                    HStack {
//                        CategoryPicker(categories: $categories, selectedCategory: $newProduct.category)
//                        VisibleToggle(visible: $newProduct.visible)
//                        Button(action: updateProduct, label: {
//                            SaveButton()}
//                        )
//                    }
//                }.whiteRecatangleRounded()
//            }
            AllGroups(groups: $groups)
        }.background(Color("background"))
        .navigationTitle("\(newProduct.name)")
        .onAppear(perform: onApper)
    }
    
    private func onApper() {
        newProduct.name = product.name ?? "Error"
        newProduct.printer = product.printer ?? "Error"
        newProduct.price1 = String(product.price1)
        newProduct.price2 = String(product.price2)
        newProduct.color = Color(hex: product.color ?? "#32CD5A")
        categories = coreDM.allCategories()
//        for categoryProduct in categories {
//            if (categoryProduct.id == product.idCategory) {
//                newProduct.category = categoryProduct
//            }
//        }
    }
    
    private func updateProduct() {
        withAnimation {
            product.name = newProduct.name
            product.printer = newProduct.printer
            product.price1 = Double(newProduct.price1) ?? 0.00
            product.price2 = Double(newProduct.price2) ?? 0.00
//            product.idCategory = newProduct.category.id
            product.color = newProduct.color.hex
            
            coreDM.update()
            products = coreDM.allProducts()
            productSelected = productSelected ? false : true
        }
    }
}

