//
//  AllModifires.swift
//  Fairway
//
//  Created by Felipe Arias on 06/12/22.
//

import SwiftUI

struct AllExtrasView: View {
    let coreDM: CoreDataManager
    @Binding var extras: [Extra]
    @State var needsRefresh = false
    @State var name = ""
    
    var body: some View {
        HStack{
            Text("Nombre").frame(maxWidth: .infinity, alignment: .leading)
            Text("Impresora").frame(maxWidth: .infinity, alignment: .leading)
            Text("Regular").frame(maxWidth: .infinity, alignment: .leading)
            Text("Door Dash").frame(maxWidth: .infinity, alignment: .leading)
            Text("Grubhub").frame(maxWidth: .infinity, alignment: .leading)
        }.padding(.horizontal, 30).bold()
        List {
            ForEach(extras, id: \.self) { product in
//                NavigationLink(destination: {ProductView(product: product,coreDM: coreDM, needsRefresh: $needsRefresh).navigationTitle("\(product.name!)")}, label: {
                    HStack{
                        Text(product.name ?? "Error").frame(maxWidth: .infinity, alignment: .leading)
                        Text(product.printer ?? "Error").frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(product.re )").frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(product.dd )").frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(product.gh )").frame(maxWidth: .infinity, alignment: .leading)
                    }
//                })
            }.onDelete(perform: { indexSet in
                indexSet.forEach { index in
                    let extra = extras[index]
                    coreDM.deleteExtra(extra: extra)
                    extras = coreDM.allExtras()
                }
            }).onAppear(perform: {
                extras = coreDM.allExtras()
            })
        }
    }
}
