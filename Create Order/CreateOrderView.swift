//
//  createOrderView.swift
//  Fairway
//
//  Created by Felipe Arias on 05/12/22.
//

import SwiftUI

struct CreateOrderView: View {
    private let coreDM = CoreDataManager()
    @State var newOrder = NewOrder(name: "", total: 0.00)
    @State var productsInOrder = [ProductInOrder]()
    @State var title = "Drinks"
    @State var quantitySelected: Int = 1
    @State var itemSelected = false
    @State var customItemActive = false
    @State var selectedProducts = [Product]()
    @State var selectedCategory = CategoryProduct()
    
    @State var products: [Product] = [Product]()
    @State var extras: [Extra] = [Extra]()
    @State var categoryProducts: [CategoryProduct] = [CategoryProduct]()
    @State var groupExtras: [GroupExtra] = [GroupExtra]()
    
//    @Binding var categoryProduct: [CategoryProduct]
//    @Binding var products: [Product]
    
    var body: some View {
        ZStack {
            VStack {
//                UpperMenuView()
                GeometryReader { geo in
                    HStack {
                        ActualOrderView(coreDM: coreDM, productsInOrder: $productsInOrder)
                            .frame(maxWidth: .infinity)
                        CategoriesView(coreDM: coreDM, selectedCategory: $selectedCategory)
                            .frame(minWidth: 100, maxWidth: 200, alignment: .topLeading)
                            .onAppear(perform: {
                                let categories = coreDM.allCategories()
                                selectedCategory = categories[0]
                            })
                        
//                        if itemSelected {
//                            ModifiresView()
//                                .frame(width: geo.size.width * 0.6).padding(.top, 35)
//                        } else {
                        OpcionsView(coreDM: coreDM, idOrder: newOrder.id, productsInOrder: $productsInOrder, selectedCategory: $selectedCategory, quantitySelected: $quantitySelected, customItemActive: $customItemActive)
                            .frame(width: geo.size.width * 0.55, alignment: .topLeading).padding(.top, 35)
//                        }
                    }.onChange(of: selectedCategory) { newValue in
                        title = newValue.name ?? "Error"
                    }
                }.background(Color("background"))
            }.frame(alignment: .trailing)
            if customItemActive {
                HStack{}.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black).opacity(0.51)
//                ViewEditCustomItem(customItemActive: $customItemActive, quantitySelected: quantitySelected)
            }
        }.navigationTitle(title).navigationBarTitleDisplayMode(.inline)
    }
}

