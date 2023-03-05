//
//  ContentView.swift
//  Fairway
//
//  Created by Felipe Arias on 03/12/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Spacer()
                NavigationLink("Nueva Orden", destination: OptionView().navigationTitle("Nueva Orden"))
                NavigationLink("Ordenes", destination: OrdersView().navigationTitle("Ordenes"))
                Spacer()
                NavigationLink("Inventario", destination: InventoryView())
            }
            OptionView().navigationTitle("Nueva Orden")
        }
    }
}
