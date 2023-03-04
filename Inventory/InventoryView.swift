//
//  InventoryView.swift
//  Fairway
//
//  Created by Felipe Arias on 12/12/22.
//

import SwiftUI

struct InventoryView: View {
    let coreDM = CoreDataManager()
    @State var extras = CoreDataManager().allExtras()
    @State var groupExtras = CoreDataManager().allGroups()
    
    var body: some View {
        List {
            NavigationLink("Nuevo Modificador", destination: NewExtraView(coreDM: coreDM, extras: $extras).navigationTitle("Nuevo Modificador"))
            NavigationLink("Modificadores", destination: AllExtrasView(coreDM: coreDM, extras: $extras).onAppear(perform: {extras = coreDM.allExtras()}).navigationTitle("Modificadores"))
            NavigationLink("Categorías", destination: AllCategoriesView())
            NavigationLink("Grupos", destination: AllGroups(groupExtras: $groupExtras).navigationTitle("Grupos"))
            NavigationLink("Uniones", destination: Unions())
        }.navigationTitle("Inventario")
    }
}


struct Titles {
    var category: some View {
        HStack {
            TitleList(title: "Nombre")
            TitleListCenter(title: "Color")
        }
    }
    var product: some View {
        HStack {
            TitleList(title: "Nombre")
            TitleList(title: "Impresora")
            TitleList(title: "Regular")
            TitleList(title: "Door Dash")
            TitleList(title: "Grubhub")
            TitleListCenter(title: "Color")
        }
    }
    var group: some View {
        HStack {
            TitleList(title: "Nombre")
        }
    }
    var extra: some View {
        HStack {
            TitleList(title: "Nombre")
            TitleList(title: "Impresora")
            TitleList(title: "Regular")
            TitleList(title: "Door Dash")
            TitleList(title: "Grubhub")
        }
    }
}
