//
//  ContentView.swift
//  Menu
//
//  Created by David Arias on 01/09/22.
//

import SwiftUI

struct OpcionsView: View {
    let coreDM: CoreDataManager
    let idOrder: Int16
//    @Binding var productsInOrder: [ProductInOrder]
    @State var customValor: String = ""
    @Binding var selectedCategory: CDCategory
    @State var producsInCategory = [CDProduct]()
    @Binding var quantitySelected: Int
    @Binding var customItemActive: Bool

    
    
    let rows = [
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        VStack{
            HStack {
                ForEach (1..<10) { quantity in
                    Button(action: {quantitySelected = quantity}, label:{
                        Text("\(quantity)")
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("backgroudOptionsProducts&Modifires"))
                            .cornerRadius(10)
                            .foregroundColor(.secondary)
                    })
                }
                
                HStack {
                    TextField("Cantidad",text: $customValor)
                        .keyboardType(.asciiCapableNumberPad)
                        .submitLabel(.continue)
                        .textInputAutocapitalization(.never)
                        .frame(maxWidth: 60, maxHeight: .infinity, alignment: .leading)
                        .cornerRadius(10)
                        .foregroundColor(.green).padding(.top, 6)
                        
                    Button(action: {
                        if let quantity = Int(customValor) {
                            quantitySelected = quantity
                        }
                    }, label: {
                        Text("Aceptar")
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .background(Color.green)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    })
                }.background(Color("backgroudOptionsProducts&Modifires"))
                    .frame(maxHeight: .infinity, alignment: .center).frame(width: 150)
                    .background(Color.white)
                    .cornerRadius(10)
                    .foregroundColor(.black)
            }.frame(height: 50).padding(.trailing, 35)
            ScrollView (.vertical) {
                LazyVGrid (columns: rows) {
                    ForEach (producsInCategory) { item in
                        Button(action: {
//                            let newProduct = ProductInOrder(idOrder: idOrder, idProduct: item.id, quantity: quantitySelected)
//                            productsInOrder.append(newProduct)
//                            quantitySelected = 1
                        }, label: {
                            HStack {
                                HStack{}.frame(maxHeight: .infinity).frame(maxWidth: 10).background(Color(hex: item.color ?? "#32CD5A"))
                                VStack {
                                    Section {
                                        Text("\(item.name!)").multilineTextAlignment(.center)
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading).padding(.leading, 10)
                                    Section {
                                        Text(String(format: "$%.2f", item.price1)).foregroundColor(.secondary)
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing).padding(.trailing, 10)
                                }
                            }.frame(maxWidth: .infinity)
                                .frame(height: 80)
                                .background(Color("backgroudOptionsProducts&Modifires"))
                                .cornerRadius(10)
                                .foregroundColor(.primary)
                            
                        }).frame(maxWidth: .infinity)
                    }
//                    ViewCustomItem(customItemActive: $customItemActive)
                }
            }.padding(.trailing, 35)
        }.onAppear {
            let categories = coreDM.allCategories()
            selectedCategory = categories[0]
            producsInCategory = products()
        }.onChange(of: selectedCategory) { newValue in
            producsInCategory = products()
        }
    }
    func products() -> [CDProduct] {
        var products = [CDProduct]()
        for product in coreDM.allProducts() {
//            if product.idCategory == selectedCategory.id {
//                products.append(product)
//            }
        }
        return products
    }
//    func addProductToList(quantitySelected: Int, item: Product) -> Void {
//        order.products += [ActualProduct(quantity: quantitySelected, product: item)]
//    }
}

