//
//  FairwayApp.swift
//  Fairway
//
//  Created by Felipe Arias on 03/12/22.
//

import SwiftUI
import CoreData

@main
struct FairwayApp: App {
    @State var titulo = ""
    let inventory = Inventory()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(inventory)
        }
    }
}
