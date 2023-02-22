//
//  ViewCustomItem.swift
//  Menú
//
//  Created by David Arias on 16/09/22.
//

//import SwiftUI
//
//struct ViewCustomItem: View {
//    
//    @Binding var customItemActive: Bool
//    
//    var body: some View {
//        Button(action: {customItemActive = true}, label:
//                {
//            VStack {
//                //HStack {
//                Section {
//                    Text("Custom Item").bold()
//                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading).padding(.leading, 10)
//                Section {
//                    Text("").foregroundColor(.secondary)
//                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing).padding(.trailing, 10)
//                HStack{
//                }.frame(height: 10).frame(maxWidth: .infinity).background(.primary)
//            }.frame(maxWidth: .infinity)
//                .frame(height: 100)
//                .background(Color("backgroudOptionsProducts&Modifires"))
//                .cornerRadius(10)
//                .foregroundColor(.primary)
//            
//        }).frame(maxWidth: .infinity)
//    }
//}
//
//struct ViewEditCustomItem: View {
//    
//    @EnvironmentObject var order: ActualOrder
//    @Binding var customItemActive: Bool
//    let quantitySelected: Int
//    
//    @State private var itemName = ""
//    @State private var itemPrice = ""
//    @State private var width = 400.0
//    @State private var height = 400.0
//    @State private var activeModifires = false
//    
//    var body: some View {
//        HStack {
//            VStack {
//                Text("Custom Item").font(.title).bold()
//                Spacer()
//                HStack {
//                    Image(systemName: "list.bullet.rectangle.portrait.fill").foregroundColor(.blue)
//                    TextField("Custom Item", text: $itemName).foregroundColor(.white).padding(.leading, 5).background(.blue).cornerRadius(30)
//                }.font(.largeTitle)
//                HStack {
//                    Image(systemName: "dollarsign.circle.fill").foregroundColor(.blue)
//                    TextField("0.00", text: $itemPrice).foregroundColor(.white).padding(.leading, 5).background(.blue).cornerRadius(30)
//                }.font(.largeTitle)
//                Spacer()
//                Button(
//                    action: {
//                        withAnimation(.spring()) {
//                            activeModifires.toggle()
//                            if activeModifires {
//                                width = 1200.0
//                                height = 600.0
//                            } else {
//                                width = 400.0
//                                height = 400.0
//                            }
//                        }
//                    },
//                    label: {
//                        Text("Modificadores")
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 40)
//                            .background(Color.orange)
//                            .cornerRadius(30)
//                            .foregroundColor(Color.white)
//                    }
//                )
//                
//                Spacer()
//                HStack {
//                    Button(
//                        action: {
//                            activeModifires = false
//                            customItemActive = false
//                        },
//                        label: {
//                            Text("Cancelar")
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 40)
//                                .background(Color.red)
//                                .cornerRadius(30)
//                        }
//                    )
//                    Button(
//                        action: {
//                            if let price = Double(itemPrice == "" ? "0.00" : itemPrice) {
//                                let customItem = Product(
//                                    name: (itemName == "" ? "Custom item" : itemName),
//                                    nameCooks: itemName,
//                                    price: price,
//                                    color: Color.purple)
//                                
//                                let actualPorduct = ActualProduct(quantity: quantitySelected, product: customItem)
//                                
//                                order.products += [actualPorduct]
//                                
//                                activeModifires = false
//                                customItemActive = false
//                            }
//                            
//                        },
//                        label: {
//                            Text("Aceptar")
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 40)
//                                .background(Color.green)
//                                .cornerRadius(30)
//                        }
//                    )
//                }.foregroundColor(Color.white)
//            }.padding(30).frame(width: 400, height: 400)
//            if activeModifires {
//                ModifiresView()
//                    .padding(.leading, 10)
//                    .padding(.top, 10)
//                    .background(Color("background"))
//                    .cornerRadius(20)
//            }
//        }
//        .padding(30).frame(width: width, height: height)
//        .background(Color.white).cornerRadius(30)
//    }
//}
