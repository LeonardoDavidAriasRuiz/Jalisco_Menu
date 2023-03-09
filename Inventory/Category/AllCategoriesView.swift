//
//  AllCategories.swift
//  Fairway
//
//  Created by Felipe Arias on 07/12/22.
//

import SwiftUI

struct AllCategoriesView: View {
    
    @EnvironmentObject var inventory: Inventory
    private let coreDM = CoreDataManager()
    
    @State private var navigationTitle = "Categorías"
    @State private var updateView = false
    @State private var new = false
    
    
    @State private var newCategory = Category()
    
    
    var body: some View {
        VStack {
            getNewItemArea()
            Titles().category.titleAllItem()
            categoryList
        }
        .navigationTitle(navigationTitle)
        .background(Color("background"))
        .toolbar {
            Menu {
                MenuButton(action: openNewItemArea, condition: $new, type: .category, button: .AddNew)
                MenuUpdate(condition1: $new, condition2: $new)
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            
        }
    }
    
    var categoryList: some View {
        List {
            ForEach(inventory.categories, id: \.self) {category in
                NavigationLink(
                    destination:
                        CategoryView(category: category),
                    label: {
                        HStack{
                            text(text: category.name ?? "Error")
                            ItemColor().color(color: Color(hex: category.color ?? "#32CD5A"))
                        }.foregroundColor(Color.accentColor)
                    }
                )
            }
            .onMove(perform: moveFromList)
            .onDelete(perform: deleteFromList)
        }
    }
    
    var newCategoryView: some View {
        VStack {
            HStack {
                TextFieldText(text: $newCategory.name)
                ChooseColor(color: $newCategory.color)
            }
            HStack {
                Button(action: saveNewCategory, label: {
                    SaveButton()}
                )
            }
        }.whiteRecatangleRounded()
    }
    
    func getNewItemArea() -> some View {
        return new ?
        VStack {
            Titles().category.titleNewItem()
            newCategoryView
        } : nil
    }
    
    func saveNewCategory() {
        withAnimation{
            coreDM.createCategory(category: newCategory)
            new = false
            newCategory.name = "-"
            newCategory.color = Color.green
            inventory.categories = coreDM.allCategories()
        }
    }
    
    func openNewItemArea() {
        withAnimation {
            new = new ? false : true
            navigationTitle = new ? "Nueva Categoría" : "Categorías"
        }
    }
    
    func moveFromList(indexSet: IndexSet, int: Int) {
        inventory.categories.move(fromOffsets: indexSet, toOffset: int)
        inventory.update()
    }
    
    func deleteFromList(indexSet: IndexSet) {
        indexSet.forEach { index in
            let groupCategory = inventory.categories[index]
            coreDM.deleteCategory(category: groupCategory)
        }
    }
}


