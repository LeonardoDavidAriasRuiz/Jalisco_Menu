//
//  Inventory.swift
//  Fairway
//
//  Created by Leonardo David Arias Ruiz on 04/03/23.
//

import SwiftUI
import CoreData

class Inventory: ObservableObject {
    
    //  Declaration and initialization of CoreData
    private var cdm = CoreDataManager()
    
    //  Lists of each Category in the Inventory
    @Published var categories: [CDCategory]
    @Published var products: [CDProduct]
    @Published var groups: [CDGroup]
    @Published var extras: [CDExtra]
    
    //  Lists for orders
    @Published var orders: [CDOrder]
    
    // Relations
    @Published var productsCategories: [CDProductCategory]
    @Published var productsCategory: [CDProduct]
    
    
    //  Initializing all the Published variables
    init() {
        // List for categories
        categories = cdm.allCategories()
        products = cdm.allProducts()
        groups = cdm.allGroups()
        extras = cdm.allExtras()
        
        //  Lists for orders
        orders = cdm.allOrders()
        
        // Relations
        productsCategories = cdm.allProductsInCategories()
        productsCategory = []
    }
    
    func update() {
        cdm.update()
    }
    
    /* ======================================================================================================
     
                                            R E L A T I O N S
     
    ====================================================================================================== */
        
    func getProductsNotInCategory(category: CDCategory) -> [CDProduct] {
        return products.filter { !category.products.contains($0) }
    }
}

extension CDCategory {
    /// Return an Array of CDProducts
    var products: [CDProduct] {
        // Lista de productos en la category
        var listOfProductsInCategory: [CDProduct] = []
        
        // Constante con el Id en UUID de la category
        let categoryId: String = String(reflecting: self.id)
        
        // Lista de todas las relaciones productInCategory que coincidadn con el id de la category
        let productsCategory = Inventory().productsCategories.filter {
            productInCategory -> Bool in
            return productInCategory.categoryID == categoryId}
        
        // Lista de todos los IDs de los productos en las relaciones productInCategory
        let productsIds = productsCategory.map { productInCategory in
            return productInCategory.productID}
        
        // Se asigna el producto a listOfOroductsInCategory si los UUIDs coinciden
        for product in Inventory().products {
            let productId: String = String(reflecting: product.id)
            if productsIds.contains(productId) {
                listOfProductsInCategory.append(product)
            }
        }
        return listOfProductsInCategory
    }
    
    /// Add a CDProduct to the CDCategory
    func addProduct(_ product: CDProduct) {
        let cdm = CoreDataManager()
        cdm.createRelationProductInCategory(product: product, category: self)
    }
    
    /// Remove a CDProduct from the CDCategory
    func removeProduct(_ product: CDProduct) {
        let cdm: CoreDataManager = CoreDataManager()
        let categoryId: String = String(reflecting: self.id)
        let productId: String = String(reflecting: product.id)
        let productsCategories: [CDProductCategory] = cdm.allProductsInCategories()
        let productCategoryToRemoveArray: [CDProductCategory] = productsCategories.filter { productInCategory -> Bool in
            let categoryIdString: String = String(reflecting: productInCategory.categoryID)
            let productIdString: String = String(reflecting: productInCategory.productID)
            return categoryIdString == categoryId && productIdString == productId}
        if let productCategoryToRemove = productCategoryToRemoveArray.first {
            cdm.deleteRelationProductInCategory(productCategory: productCategoryToRemove)
        }
    }
}
