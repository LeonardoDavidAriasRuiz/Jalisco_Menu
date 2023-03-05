//
//  NewExtra.swift
//  Fairway
//
//  Created by Felipe Arias on 07/12/22.
//

import SwiftUI

struct NewExtraView: View {
    @State var name = "-"
    @State var printer = "-"
    @State var priceDD = "0.00"
    @State var priceGH = "0.00"
    @State var priceRE = "0.00"
    @State var color = Color.green
    
    let coreDM: CoreDataManager
    @Binding var extras: [CDExtra]
    
    var body: some View {
        VStack {
            SeccionTextField(title: "Nombre", empty: "Nombre del producto", symbol: "character.cursor.ibeam", text: $name)
            SeccionTextField(title: "Impresora", empty: "Nombre para impresora", symbol: "printer.fill", text: $printer)
            SeccionTextField(title: "Precio Regular", empty: "Precio del producto", symbol: "dollarsign", text: $priceRE)
            SeccionTextField(title: "Precio Door Dash", empty: "Precio en Door Dash", symbol: "car.fill", text: $priceDD)
            SeccionTextField(title: "Precio GRUBHUB", empty: "Precio en GRUBHUB", symbol: "fork.knife", text: $priceGH)
            HStack {
                Button(action: saveNewExtra, label: {
                        SaveButton()}
                )
            }
        }
    }
    
    func saveNewExtra() {
        withAnimation{
            extras = coreDM.allExtras()
            coreDM.createExtra(
                name: name,
                printer: printer,
                priceDD: Double(priceDD) ?? 0.00,
                priceGH: Double(priceGH) ?? 0.00,
                priceRE: Double(priceRE) ?? 0.00)
        }
    }
}
