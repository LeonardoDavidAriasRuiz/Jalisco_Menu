//
//  NewOrder.swift
//  Fairway
//
//  Created by Felipe Arias on 10/12/22.
//

import Foundation

struct NewOrder {
    let id: UUID = UUID()
    let date: Date = Date()
    let type: String = ""
    var name: String = ""
    var total: Double = 0.00
}
