//
//  ProductInOrder.swift
//  Fairway
//
//  Created by Felipe Arias on 10/12/22.
//

import Foundation

struct ProductInOrder: Identifiable{
    let id = Int16()
    let idOrder: Int16
    let idProduct: Int16
    var quantity: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
