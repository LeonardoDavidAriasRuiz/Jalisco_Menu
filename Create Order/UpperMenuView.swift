//
//  UpperMenuView.swift
//  Menu
//
//  Created by David Arias on 11/09/22.
//

//import SwiftUI
//
//struct UpperMenuView: View {
//    
//    @EnvironmentObject var order: ActualOrder
//    
//    var body: some View {
//        Section {
//            Menu {
//                EditButton()
//                Button(
//                    action: {order.products = []},
//                    label: {
//                        HStack {
//                            Text("Eliminar orden").foregroundColor(Color.red)
//                            Image(systemName: "trash.fill").foregroundColor(Color.red)
//                        }
//                    }
//                )
//            } label: {
//                Image(systemName: "ellipsis.circle").font(.title)
//            }
//        }.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 35)
//    }
//}
//
//struct UpperMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpperMenuView()
//    }
//}
