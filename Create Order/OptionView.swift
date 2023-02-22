//
//  OptionView.swift
//  Fairway
//
//  Created by Felipe Arias on 05/12/22.
//

import SwiftUI

struct OptionView: View {
    let doorDash = OrderType(name: "Door Dash", color: Color.red)
    let grubhub = OrderType(name: "GRUBHUB", color: Color.orange)
    let online = OrderType(name: "Online", color: Color.green)
    let phoneOrder = OrderType(name: "Phone Order", color: Color.blue)
    let dineIn = OrderType(name: "Dine in", color: Color.brown)
    
    var body: some View {
        VStack {
            
            buttonOrderType(orderType: doorDash).padding(.top, 20)
            buttonOrderType(orderType: grubhub)
            buttonOrderType(orderType: online)
            buttonOrderType(orderType: phoneOrder)
            buttonOrderType(orderType: dineIn).padding(.bottom, 20)
        }
        .frame(width: 500)
        .background(Color("backgroudOptionsProducts&Modifires"))
        .cornerRadius(15)
        .shadow(radius: 30)
    }
}


struct buttonOrderType: View {
    let orderType: OrderType
    
    var body: some View {
        NavigationLink(
            destination: {
                CreateOrderView()
            }, label: {
                Text(orderType.name)
                    .fontWeight(Font.Weight.black)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 70)
                    .background(orderType.color)
                    .cornerRadius(10)
            }
        ).padding(.horizontal, 20)
    }
}

struct OrderType {
    let name: String
    let color: Color
}
