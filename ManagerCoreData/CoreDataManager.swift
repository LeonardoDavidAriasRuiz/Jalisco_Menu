//
//  CoreDataManager.swift
//  Fairway
//
//  Created by Felipe Arias on 06/12/22.
//


import CoreData
import SwiftUI

class CoreDataManager {
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Data")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }
    
    func update() {
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
        }
    }
    
    func createProduct(newProduct: NewProduct) {
        let product = CDProduct(context: context)
        product.id = 1
        product.name = newProduct.name
        product.printer = newProduct.printer
        product.color = newProduct.color.hex
        product.visible = newProduct.visible
        product.idCategory = newProduct.category.id
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save the product \(error)")
        }
    }
    
    func allProducts() -> [CDProduct] {
        let fetchRequest: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteProduct(product: CDProduct) {
        
        CoreDataManager.persistentContainer.viewContext.delete(product)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
    func createExtra(name: String,printer: String, priceDD: Double, priceGH: Double, priceRE: Double) {
        let extra = CDExtra(context: context)
        extra.id = 1
        extra.name = name
        extra.printer = printer
        extra.dd = priceDD
        extra.gh = priceGH
        extra.re = priceRE
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save the product \(error)")
        }
    }
    
    func allExtras() -> [CDExtra] {
        let fetchRequest: NSFetchRequest<CDExtra> = CDExtra.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteExtra(extra: CDExtra) {
        
        CoreDataManager.persistentContainer.viewContext.delete(extra)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
    func createCategory(category: Category) {
        let CDcategory = CDCategory(context: context)
        CDcategory.id = 1
        CDcategory.name = category.name
        CDcategory.color = category.color.hex
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save the product \(error)")
        }
    }
    
    func allCategories() -> [CDCategory] {
        let fetchRequest: NSFetchRequest<CDCategory> = CDCategory.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteCategory(category: CDCategory) {
        
        CoreDataManager.persistentContainer.viewContext.delete(category)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func createGroup(name: String) {
        let groupExtra = CDGroup(context: context)
        groupExtra.id = 1
        groupExtra.name = name
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save the product \(error)")
        }
    }
    
    func allGroups() -> [CDGroup] {
        let fetchRequest: NSFetchRequest<CDGroup> = CDGroup.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteGroup(CDgroup: CDGroup) {
        
        CoreDataManager.persistentContainer.viewContext.delete(CDgroup)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func createOrder(newOrder: NewOrder) {
        let order = CDOrder(context: context)
        order.id = 1
        order.date = newOrder.date
        order.type = newOrder.type
        order.name = newOrder.name
        order.total = newOrder.total
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save the product \(error)")
        }
    }
    
    func allOrders() -> [CDOrder] {
        let fetchRequest: NSFetchRequest<CDOrder> = CDOrder.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteOrder(CDorder: CDOrder) {
        
        CoreDataManager.persistentContainer.viewContext.delete(CDorder)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
}
