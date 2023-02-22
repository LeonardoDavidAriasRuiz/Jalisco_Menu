//
//  ProductView.swift
//  Fairway
//
//  Created by Felipe Arias on 12/21/22.
//

import SwiftUI

struct ProductView: View {
    
    @State private var groups = CoreDataManager().allGroups()
    @State private var navigationTitle = "Categoría"
    @State private var update = false
    @State private var selected = false
    private let coreDM = CoreDataManager()
    
    let product: Product
    
    var body: some View {
        VStack {
            if update {
//                getUpdateCategoryArea()
            }
            groupsList
        }
        .navigationBarTitle(navigationTitle)
        .onAppear(perform: onAppear)
        .background(Color("background"))
        .toolbar {
            ToolbarItem {
                Menu {
                    MenuButton(action: updateButtonAction, condition: $update, type: .product, button: .EditItem)
                    MenuUpdate(condition1: $update, condition2: $update)
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
    
    let columns = [
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem()
    ]
    
    var groupsList: some View {
        LazyVGrid (columns: columns) {
            ForEach(groups, id: \.self) { group in
                Button {
                    union(group: group)
                } label: {
                    SelectGroupOption(product: product, group: group, selected: $selected)
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(35)
    }
    
    func union(group: GroupExtra) {
        var encontrado = false
        let groupsProduct = coreDM.allGroupsProduct()
        if groupsProduct.isEmpty {
            coreDM.createGroupsProduct(idGroup: group.id!, idProduct: product.id!)
            groups = coreDM.allGroups()
            selected = selected ? false : true
            return
        }
        for union in groupsProduct {
            if union.idProduct == product.id && union.idGroup == group.id {
                coreDM.deleteGroupsProduct(grousProduct: union)
                encontrado = true
                groups = coreDM.allGroups()
                selected = selected ? false : true
                return
            }
        }
        if !encontrado {
            coreDM.createGroupsProduct(idGroup: group.id!, idProduct: product.id!)
            groups = coreDM.allGroups()
            selected = selected ? false : true
            return
        }
    }
    
    func updateButtonAction() {
        update = true
    }
    
    func onAppear() {
        
    }
}

