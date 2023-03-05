//
//  Unions.swift
//  Fairway
//
//  Created by Felipe Arias on 12/30/22.
//

import SwiftUI

//struct Unions: View {
//    @State var unions = CoreDataManager().allGroupsProduct()
//    var body: some View {
//        List {
//            ForEach(unions, id: \.self) { union in
//                HStack {
//                    Text(getUnionProduct(union: union))
//                    Text(getUnionGroup(union: union))
//                }
//            }.onDelete(perform: deleteFromList)
//        }.onAppear(perform: onAppear)
//    }
//
//    func onAppear() {
//        unions = CoreDataManager().allGroupsProduct()
//    }
//
//    func deleteFromList(indexSet: IndexSet) {
//        indexSet.forEach { index in
//            let union = unions[index]
//            CoreDataManager().deleteGroupsProduct(grousProduct: union)
//            unions = CoreDataManager().allGroupsProduct()
//        }
//    }
//
//    func getUnionGroup(union: GroupsProduct) -> String {
//        for group in CoreDataManager().allGroups(){
//            if group.id == union.idGroup {
//                return group.name ?? "Error"
//            }
//        }
//        return "No se encontró"
//    }
//
//    func getUnionProduct(union: GroupsProduct) -> String {
//        for product in CoreDataManager().allProducts() {
//            if product.id == union.idProduct {
//                return product.name ?? "Error"
//            }
//        }
//        return "No se encontró"
//    }
//}
//
//struct Unions_Previews: PreviewProvider {
//    static var previews: some View {
//        Unions()
//    }
//}
