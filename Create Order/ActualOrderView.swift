//
//  ActualView.swift
//  Menu
//
//  Created by David Arias on 10/09/22.
//

import SwiftUI

struct ActualOrderView: View {
    let coreDM: CoreDataManager
    @Binding var productsInOrder: [ProductInOrder]
    @State var subtotal: Double = 0
    
    var body: some View {
        VStack {
            List {
                ForEach (productsInOrder) { product in
                    buttonListProduct(product: product, name: productName(productInOrder: product).name!, price: productName(productInOrder: product).re)
                }
                .onDelete(perform: deleteFromList)
                .onMove(perform: moveFromList)
            }
//            .onChange(of: order.products, perform: changeTotal)
//            total
        }
    }
    
    func deleteFromList(indexSet: IndexSet) {
        productsInOrder.remove(atOffsets: indexSet)
    }
    func moveFromList(indexSet: IndexSet, int: Int) {
        productsInOrder.move(fromOffsets: indexSet, toOffset: int)
    }
    
    func productName(productInOrder: ProductInOrder) -> Product {
        for productFromAll in coreDM.allProducts() {
            if productInOrder.idProduct == productFromAll.id {
                return productFromAll
            }
        }
        return Product()
    }
    
//    func changeTotal(actualproducts: [ActualProduct]) {
//        subtotal = 0
//        for item in order.products{
////            subtotal += Double(item.quantity) *  item.product.price
//        }
    }
    
    var total: some View {
        VStack {
            VStack {
                HStack {
                    Text("Subtotal:")
//                    Text(String(format: "$%.2f", subtotal)).foregroundColor(.secondary)
                }.font(.title2)
                HStack {
                    Text("Taxes:")
//                    Text(String(format: "$%.2f", subtotal*0.0775)).foregroundColor(.secondary)
                }.font(.title2)
                HStack {
                    Text("Total:").bold()
//                    Text(String(format: "$%.2f", subtotal + (subtotal*0.0775))).bold().foregroundColor(.secondary)
                }.font(.title)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack {

            }.frame(height: 20)
                .frame(maxWidth: .infinity, alignment: .bottom)
                .background(.red)

        }.frame(maxWidth: .infinity, maxHeight: 170).background(Color("backgroudOptionsProducts&Modifires")).cornerRadius(30)
    }
//}
//
struct buttonListProduct: View {
    var product: ProductInOrder
    var name: String
    var price: Double

    var body: some View {
        Button(action: {}, label:
                {
            VStack {
                HStack {
                    Text("\(product.quantity)").foregroundColor(.green).bold().font(.title2)
                    Section {
                        Text("\(name)").foregroundColor(.primary)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    Section {
                        Text(String(format: "$%.2f", price * Double(product.quantity))).foregroundColor(.secondary)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                }
//                ForEach (product.modifires) { modifire in
//                    Text("\(modifire.name)").foregroundColor(.secondary).frame(maxWidth: .infinity, alignment: .leading)
//                }

            }
        })
    }
}
