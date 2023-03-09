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
    
    func createProduct(product: Product) {
        let CDproduct = CDProduct(context: context)
        CDproduct.name = product.name
        CDproduct.printer = product.printer
        CDproduct.price1 = Double(product.price1) ?? 0.00
        CDproduct.price2 = Double(product.price2) ?? 0.00
        CDproduct.color = product.color.hex
        
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
    
    func createExtra(extra: Extra) {
        let CDextra = CDExtra(context: context)
        CDextra.name = extra.name
        CDextra.printer = extra.printer
        CDextra.price1 = Double(extra.price1) ?? 0.00
        CDextra.price2 = Double(extra.price2) ?? 0.00
        
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
    
    func createRelationProductInCategory(product: CDProduct, category: CDCategory) {
        let relation = CDProductCategory(context: context)
        let productID = String(reflecting: product.id)
        let categoryID = String(reflecting: category.id)
        relation.productID = productID
        relation.categoryID = categoryID
        
//        do {
//            try CoreDataManager.persistentContainer.viewContext.save()
//        } catch {
//            print("Fail to save the product \(error)")
//        }
    }
    
    func allProductsInCategories() -> [CDProductCategory] {
        let fetchRequest: NSFetchRequest<CDProductCategory> = CDProductCategory.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteRelationProductInCategory(productCategory: CDProductCategory) {
        
        CoreDataManager.persistentContainer.viewContext.delete(productCategory)
//
//        do {
//            try CoreDataManager.persistentContainer.viewContext.save()
//        } catch {
//            CoreDataManager.persistentContainer.viewContext.rollback()
//            print("Failed to save context \(error)")
//        }
    }
}

extension NSManagedObjectID {
    var uuid: UUID {
        let urldString = self.uriRepresentation().absoluteString
        let urlArray = urldString.split(separator: "/")
        let uuidString = String(urlArray[1])
        print(CoreDataManager().allCategories()[0].id)
        print(CoreDataManager().allCategories()[1].id)
        print(CoreDataManager().allCategories()[2].id)
        print(CoreDataManager().allCategories()[3].id)
        
        print(uuidString)
        return UUID(uuidString: uuidString)!
    }
}
