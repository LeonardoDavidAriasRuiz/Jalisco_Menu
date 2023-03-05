//
//  Inventory.swift
//  Fairway
//
//  Created by Leonardo David Arias Ruiz on 04/03/23.
//

import SwiftUI

class Inventory: ObservableObject {
    
    //  Declaration and initialization of CoreData
    private var cdm = CoreDataManager()
    
    
    
    //  Lists of each Category in the Inventory
    @Published var categories: [CategoryProduct]
    @Published var products: [Product]
    @Published var groups: [GroupExtra]
    @Published var extras: [Extra]
    
    //  Lists of each union between Categories in the Inventory
    @Published var productsOfEachCategory: [GroupsProduct]
    /*@Published var groupsOfEachProduct: []*/
    /* @Published var extrasOfEachGroup: [] */
    
    //  Lists for orders
    @Published var orders: [Order]
    @Published var productsOfEachOrder: [OrderProduct]
    
    
    
    //  Initializing all the Published variables
    init() {
        categories = cdm.allCategories()
        products = cdm.allProducts()
        groups = cdm.allGroups()
        extras = cdm.allExtras()
        
        //  Lists of each union between Categories in the Inventory
        productsOfEachCategory = cdm.allGroupsProduct()
        /*groupsOfEachProduct    = cdm.all */
        /* @Published var extrasOfEachGroup = CoreDataManager().all */
        
        //  Lists for orders
        orders                 = cdm.allOrders()
        productsOfEachOrder    = cdm.allOrderProducts()
    }
    
    func update() {
        cdm.update()
    }
}
