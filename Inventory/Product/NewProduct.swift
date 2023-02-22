//
//  NewProduct.swift
//  Fairway
//
//  Created by Felipe Arias on 11/12/22.
//

import Foundation
import SwiftUI

struct NewProduct {
    var name: String = "-"
    var printer: String = "-"
    var dd: String = "0.00"
    var gh: String = "0.00"
    var re: String = "0.00"
    var red: Double = 0.207
    var green: Double = 0.78
    var blue: Double = 0.349
    var visible: Bool = true
    var category: CategoryProduct = CategoryProduct()
    var color: Color = Color(red: 0.207, green: 0.78, blue: 0.349)
}
