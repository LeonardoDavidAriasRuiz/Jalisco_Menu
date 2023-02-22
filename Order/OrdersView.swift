//
//  OrdersView.swift
//  Fairway
//
//  Created by Felipe Arias on 05/12/22.
//

import SwiftUI

struct OrdersView: View {
    
    private var people = [
        People(name: "Juan", number: "12", total: "12.99", hour: "3/4/2022"),
        People(name: "Mei", number: "44", total: "11.49", hour: "3/4/2022"),
        People(name: "Tom", number: "65", total: "12.99", hour: "3/4/2022"),
        People(name: "Gita", number: "32", total: "11.49", hour: "3/4/2022")
    ]

    var body: some View {
        Table(people) {
            TableColumn("Nombre", value: \.name)
            TableColumn("Número", value: \.number)
            TableColumn("Total", value: \.total)
            TableColumn("Total", value: \.hour)
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}


struct People: Identifiable {
    let id = UUID()
    let name: String
    let number: String
    let total: String
    let hour: String
}

