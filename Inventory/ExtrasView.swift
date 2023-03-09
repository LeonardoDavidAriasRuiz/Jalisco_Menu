//
//  ExtrasView.swift
//  Fairway
//
//  Created by Leonardo David Arias Ruiz on 05/03/23.
//

import SwiftUI

struct ExtrasView: View {
    @EnvironmentObject private var inventory: Inventory
    @State private var extra = Extra()
    var body: some View {
        ZStack {
            VStack {
                newProductArea
                productsList
                
            }.background(Color("background"))
        }
    }
    
    var newProductArea: some View {
        VStack {
            Titles().extra
            HStack {
                TextFieldText(text: $extra.name)
                TextFieldText(text: $extra.printer)
                TextFieldText(text: $extra.price1)
                TextFieldText(text: $extra.price2)
            }
            Button(action: createExtra, label: {SaveButton()})
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.white)
        .cornerRadius(10)
        .padding(20)
    }
    
    var productsList: some View {
        List{
            ForEach(inventory.extras, id: \.self) { extra in
                HStack {
                    Text(extra.name ?? "")
                }
            }
            .onDelete(perform: deleteExtra)
        }
    }
    
    func createExtra() {
        CoreDataManager().createExtra(extra: extra)
        extra = Extra()
        inventory.extras = CoreDataManager().allExtras()
    }
    
    func deleteExtra(indexSet: IndexSet) {
        indexSet.forEach { index in
            CoreDataManager().deleteExtra(extra: inventory.extras[index])
            inventory.extras = CoreDataManager().allExtras()
        }
    }
}

struct Extra {
    var name: String = ""
    var printer: String = ""
    var price1: String = "0.00"
    var price2: String = "0.00"
}

struct ExtrasView_Previews: PreviewProvider {
    static var previews: some View {
        ExtrasView()
    }
}
