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
    var visible: Bool = true
    var category: CategoryProduct = CategoryProduct()
    var color: Color = Color.green
}
