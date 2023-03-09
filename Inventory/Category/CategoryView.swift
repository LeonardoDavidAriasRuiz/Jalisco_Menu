//
//  AllProductsView.swift
//  Fairway
//
//  Created by Felipe Arias on 05/12/22.
//

import SwiftUI

struct CategoryView: View {
    private let coreDM = CoreDataManager()
    private let noCategoriesTitle: String = "Error"
    
    @State private var navigationTitle = "Categoría"
    @State private var update = false
    @State private var new = false
    
    
    @State private var products = CoreDataManager().allProducts()
    @State private var categories = CoreDataManager().allCategories()
    @State private var categoryUpdate = Category()
    @State private var newProduct = Product()
    
    let category: CDCategory
    
    var body: some View {
        VStack {
            if new {
                getNewProductArea()
            }
            if update {
                getUpdateCategoryArea()
            }
            Titles().product.titleAllItem()
            productsList
        }
        .navigationBarTitle(navigationTitle)
        .onAppear(perform: onAppear)
        .background(Color("background"))
        .toolbar {
            ToolbarItem {
                Menu {
                    MenuButton(action: newButtonAction, condition: $new, type: .product, button: .AddNew)
                    MenuButton(action: updateButtonAction, condition: $update, type: .category, button: .EditItem)
                    MenuUpdate(condition1: $new, condition2: $update)
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
    
    var productsList: some View {
        List {
//            ForEach(products, id: \.self) { product in
//                if product.idCategory == category.id {
//                    NavigationLink(
//                        destination: ProductView(product: product),
//                        label: {
//                            HStack {
//                                text(text: product.name ?? "Error")
//                                text(text: product.printer ?? "Error")
//                                text(text: String(format: "$%.2f", product.re))
//                                text(text: String(format: "$%.2f", product.dd))
//                                text(text: String(format: "$%.2f", product.gh))
//                                ItemColor()
//                                    .color(red: product.red, green: product.green, blue: product.blue)
//                            }.foregroundColor(Color.accentColor)
//                            
//                        }
//                    )
//                }
//            }
//            .onDelete(perform: deleteFromList)
//            .onMove(perform: moveFromList)
        }
    }
    
    var updateCategoryArea: some View {
        VStack {
            HStack {
                TextFieldText(text: $categoryUpdate.name)
                ChooseColor(color: $categoryUpdate.color)
            }
            Button(action: updateButton , label: {
                SaveButton()}
            )
        }
    }
    
    var newProductArea: some View {
        VStack {
            HStack {
                TextFieldText(text: $newProduct.name)
                TextFieldText(text: $newProduct.printer)
                TextFieldNumber(text: $newProduct.price1)
                TextFieldNumber(text: $newProduct.price2)
                ChooseColor(color: $newProduct.color)
            }
            HStack {
                Button(action: saveNewProduct, label: {
                    SaveButton()}
                )
            }
        }
    }
    
    func saveNewProduct() {
        withAnimation {
            coreDM.createProduct(product: newProduct)
            updateList()
            getProductsList()
            new = false
        }
    }
    
    func getUpdateCategoryArea() -> some View {
        VStack {
            Titles().category.titleNewItem()
            updateCategoryArea
                .whiteRecatangleRounded()
        }
    }
    
    func getNewProductArea() -> some View {
        VStack {
            Titles().product.titleNewItem()
            newProductArea
                .whiteRecatangleRounded()
        }
    }
    
    func noCategoriesMessage() -> some View {
        let noCategoriesMessage = "Agrega una categoría primero."
        return Text(noCategoriesMessage)
    }
    
    func newButtonAction() {
        withAnimation {
            update = false
            new = new ? false : true
        }
    }
    func updateButtonAction() {
        withAnimation {
            new = false
            update = update ? false : true
        }
    }
    
    func updateButton() {
        withAnimation {
            category.name = categoryUpdate.name
            category.color = categoryUpdate.color.hex
            update = false
        }
    }
    
    func openNewItemArea() {
        withAnimation {
            new = new ? false : true
            navigationTitle = new ? "Nueva Categoría" : "Categorías"
        }
    }
    
    func moveFromList(indexSet: IndexSet, int: Int) {
        products.move(fromOffsets: indexSet, toOffset: int)
        updateList()
        getProductsList()
    }
    
    func deleteFromList(indexSet: IndexSet) {
        indexSet.forEach { index in
            let product = products[index]
            coreDM.deleteProduct(product: product)
            getProductsList()
        }
    }
    
    func onAppear() {
        categoryUpdate.name = category.name ?? "Error"
        categoryUpdate.color = Color(hex: category.color ?? "#32CD5A")
        navigationTitle = categoryUpdate.name
        getProductsList()
    }
    func getProductsList() {
        products = coreDM.allProducts()
    }
    
    func updateList() {
        coreDM.update()
    }
}
