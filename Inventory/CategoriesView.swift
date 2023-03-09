//
//  CategoriesView.swift
//  Fairway
//
//  Created by Leonardo David Arias Ruiz on 05/03/23.
//

import SwiftUI


/* **************************************************************

              Vista donde se controlaran las CATEGORIES:
                             Crear
                           Visualizar
                            Eliminar
                             Editar

*************************************************************** */

struct CategoriesView: View {
    @EnvironmentObject private var inventory: Inventory
    @State private var category = Category()
    @State private var categoryIsSelected = false
    @State private var categorySelected = CDCategory()
    @State private var categoryToEdit = Category()
    @State private var productsInCatgory: [CDProduct] = []
    @State private var productsNotInCatgory: [CDProduct] = []
    
    /* ==========================================================
    
                  C U E R P O     D E     V I S T A
    
    ========================================================== */
    var body: some View {
        ZStack {
            VStack {
                newCategoryArea
                categoryList
            }.background(Color("background"))
            if categoryIsSelected == true {
                VStack {
                    editCategoryArea
                    HStack {
                        listOfProducts
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hue: 0.63, saturation: 0.331, brightness: 0.379, opacity: 0.5))
            }
        }
    }
    
    
    
    /* ==========================================================
    
                 AREA DONDE SE MUESTRAN LOS PRODUCTOS
                   RELACIONADOS CON LA CATEGORIA
    
    ========================================================== */
    let columns = [GridItem(), GridItem(),GridItem(), GridItem(),GridItem()]
    var listOfProducts: some View {
        HStack {
            VStack {
                ScrollView {
                    ForEach(productsNotInCatgory, id: \.self) { product in
                        Button {
                            addProductToCategory(category: categorySelected, product: product)
                        } label: {
                            Text(product.name ?? "Error")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
            .frame(maxWidth: 100, maxHeight: .infinity)
            .padding(20)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.leading, 20)
            .padding(.trailing, 10)
            LazyVGrid(columns: columns) {
                ForEach(productsInCatgory, id: \.self) { product in
                    Button {
                        deleteProductFromCategory(category: categorySelected, product: product)
                    } label: {
                        Text(product.name ?? "Error")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.vertical, 5)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(20)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.trailing, 20)
        }
    }
    
    
    
    /* ==========================================================
    
             AREA DONDE SE EDITA LA CATEGORIA SELECCIONADA
    
    ========================================================== */
    var editCategoryArea: some View {
        VStack {
            Titles().category
            HStack {
                TextFieldText(text: $categoryToEdit.name)
                ChooseColor(color: $categoryToEdit.color)
            }
            HStack {
                Button(action: editCategory, label: {SaveButton()})
                Button(action: cancelEdition) {
                    Image(systemName: "pencil.slash")
                    .foregroundColor(Color.white)
                    .padding(5)
                    .background(Color.red)
                    .cornerRadius(100)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    
    
    
    /* ==========================================================
    
                AREA DONDE SE CREA LA CATEGORIA NUEVA
    
    ========================================================== */
    var newCategoryArea: some View {
        VStack {
            Titles().category
            HStack {
                TextFieldText(text: $category.name)
                ChooseColor(color: $category.color)
            }
            Button(action: createCategory, label: {SaveButton()})
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.white)
        .cornerRadius(10)
        .padding(20)
    }
    
    
    
    /* ==========================================================
    
             AREA DONDE SE MUESTRAN TODAS LAS COTEGORIAS
    
    ========================================================== */
    var categoryList: some View {
        List{
            ForEach(inventory.categories, id: \.self) { category in
                HStack {
                    Button(action: {selectCategory(category: category)}, label: {
                        HStack {
                            Circle()
                                .frame(maxHeight: 20)
                                .foregroundColor(Color(hex: category.color ?? "#FF0023"))
                            Text(category.name ?? "")
                        }
                    })
                }
            }
            .onDelete(perform: deleteCategory)
        }
    }
    
    
    
    // ==========================================================
    // Funcion donde se crea la nueva "Categoría"
    // ==========================================================
    func createCategory() {
        CoreDataManager().createCategory(category: category)
        category = Category()
        inventory.categories = CoreDataManager().allCategories()
    }
    
    
    
    // ==========================================================
    // Funcion donde se elimina la "Categoría"
    // ==========================================================
    func deleteCategory(indexSet: IndexSet) {
        indexSet.forEach { index in
            CoreDataManager().deleteProduct(product: inventory.products[index])
            inventory.categories = CoreDataManager().allCategories()
        }
    }
    
    // ==========================================================
    // Funcion donde se selecciona la "Categoría"
    // ==========================================================
    func selectCategory(category: CDCategory) {
        withAnimation {
            categorySelected = category
            categoryToEdit = Category(category: category)
            categoryIsSelected = true
            productsInCatgory = categorySelected.products
            productsNotInCatgory = inventory.getProductsNotInCategory(category: categorySelected)
        }
    }
    
    // ==========================================================
    // Funcion donde se edita la "Categoría"
    // ==========================================================
    func editCategory() {
        withAnimation {
            categorySelected.name = categoryToEdit.name
            categorySelected.color = categoryToEdit.color.hex
            categoryIsSelected = false
            inventory.update()
            inventory.categories = CoreDataManager().allCategories()
            
        }
    }
    
    // =============================================================
    // Funcion para cancelar la edicion de la Categotia actual
    // =============================================================
    func cancelEdition() {
        withAnimation {
            categoryIsSelected = false
            categoryToEdit = Category()
            categorySelected = CDCategory()
        }
    }
    
    // =============================================================
    // Funcion donde se agrega la relacion de Category - Product
    // =============================================================
    func addProductToCategory(category: CDCategory, product: CDProduct) {
        withAnimation {
            category.addProduct(product)
            productsInCatgory = category.products
            productsNotInCatgory = inventory.getProductsNotInCategory(category: categorySelected)
        }
        
    }
    /** =============================================================
    // Funcion donde se agrega la relacion de Category - Product
    // =============================================================*/
    func deleteProductFromCategory(category: CDCategory, product: CDProduct) {
        withAnimation {
            inventory.deleteProductFromCategory(category: category, product: product)
            productsInCatgory = category.products
            productsNotInCatgory = inventory.getProductsNotInCategory(category: categorySelected)
        }
        
    }
}

struct Category {
    var name: String
    var color: Color = Color.green
    
    init() {
        self.name = ""
        self.color = Color.green
    }

    init(name: String, color: Color) {
        self.name = name
        self.color = color
    }
    
    
    init(category: CDCategory) {
        self.name = category.name ?? "Error"
        self.color = Color(hex: category.color ?? "#FF0023")
    }
}
