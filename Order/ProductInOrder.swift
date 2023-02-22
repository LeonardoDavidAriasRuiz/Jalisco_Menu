//
//  ProductInOrder.swift
//  Fairway
//
//  Created by Felipe Arias on 10/12/22.
//

import Foundation

struct ProductInOrder: Identifiable{
    let id = UUID()
    let idOrder: UUID
    let idProduct: UUID
    var quantity: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
