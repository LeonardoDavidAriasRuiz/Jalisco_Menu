////
////  ModifiresView.swift
////  Menu
////
////  Created by David Arias on 10/09/22.
////
//
//import SwiftUI
//
//struct ModifiresView: View {
//    
//    var modificador = ModifireGroup()
//    
//    var body: some View {
//        VStack {
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach (modificador.moifireGroup) { item in
//                        modifireGroupButton(modifireGroup: item)
//                    }
//                }
//                
//            }.frame(height: 50, alignment: .leading)
//            ScrollView {
//                
//                let rows = [
//                    GridItem(),
//                    GridItem(),
//                    GridItem()
//                ]
//                
//                LazyVGrid (columns: rows) {
//                    ForEach (modificador.moifireGroup[0].modifires) { modifire in
//                        modifireButton(name: modifire.name, price: modifire.price)
//                    }
//                }
//            }.padding(.trailing, 40)
//        }
//    }
//}
//
//struct modifireGroupButton: View {
//    
//    var modifireGroup: Modifires
//    
//    var body: some View {
//        Button(action: {}, label:
//                {
//            Text("\(modifireGroup.name)")
//                .frame(width: 100,alignment: .center)
//                .frame(maxHeight: .infinity)
//                .background(Color.white)
//                .cornerRadius(10)
//                .foregroundColor(.black)
//            
//        }
//        ).frame(maxWidth: .infinity)
//    }
//}
//
//struct modifireButton: View {
//    let name: String
//    let price: Double
//    @State private var selected = false
//    
//    var body: some View {
//        Button(
//            action: {
//                withAnimation(.spring()) {
//                    selected.toggle()
//                }
//            }, label:{
//                HStack {
//                    if selected {
//                        Button(action: {}, label: {Image(systemName: "multiply.circle.fill").font(.title).scaledToFit().foregroundColor(Color.red  )})
//                    }
//                    VStack {
//                        Text("\(name)")
//                            .foregroundColor(Color.black)
//                            .frame(maxHeight: .infinity, alignment: .bottom)
//                        Text(String(format: "$%.2f", price))
//                            .foregroundColor(.secondary)
//                            .frame(maxHeight: .infinity, alignment: .top)
//                    }.frame(maxWidth: .infinity)
//                    if selected {
//                        Button(action: {}, label: {Image(systemName: "plus.circle.fill"    ).font(.title).scaledToFit().foregroundColor(Color.green)})
//                    }
//                }.frame(maxWidth: .infinity)
//                    .background(Color.white)
//                    .cornerRadius(10)
//            }
//        )
//    }
//}
