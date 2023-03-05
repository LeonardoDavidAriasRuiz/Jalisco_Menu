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
        let product = Product(context: context)
        product.id = UUID()
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
    
    func allProducts() -> [Product] {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteProduct(product: Product) {
        
        CoreDataManager.persistentContainer.viewContext.delete(product)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
    func createExtra(name: String,printer: String, priceDD: Double, priceGH: Double, priceRE: Double) {
        let extra = Extra(context: context)
        extra.id = UUID()
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
    
    func allExtras() -> [Extra] {
        let fetchRequest: NSFetchRequest<Extra> = Extra.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteExtra(extra: Extra) {
        
        CoreDataManager.persistentContainer.viewContext.delete(extra)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
    func createCategory(name: String, color: Color) {
        let category = CategoryProduct(context: context)
        category.id = UUID()
        category.name = name
        category.color = color.hex
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save the product \(error)")
        }
    }
    
    func allCategories() -> [CategoryProduct] {
        let fetchRequest: NSFetchRequest<CategoryProduct> = CategoryProduct.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteCategory(categoryProduct: CategoryProduct) {
        
        CoreDataManager.persistentContainer.viewContext.delete(categoryProduct)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func createGroup(name: String) {
        let groupExtra = GroupExtra(context: context)
        groupExtra.id = UUID()
        groupExtra.name = name
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save the product \(error)")
        }
    }
    
    func allGroups() -> [GroupExtra] {
        let fetchRequest: NSFetchRequest<GroupExtra> = GroupExtra.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteGroup(groupExtra: GroupExtra) {
        
        CoreDataManager.persistentContainer.viewContext.delete(groupExtra)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func createOrder(newOrder: NewOrder) {
        let order = Order(context: context)
        order.id = newOrder.id
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
    
    func allOrders() -> [Order] {
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteOrder(order: Order) {
        
        CoreDataManager.persistentContainer.viewContext.delete(order)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func createOrderProduct(idOrder: UUID, idProduct: UUID, quantity: Int) {
        let orderProduct = OrderProduct(context: context)
        orderProduct.idOrder = idOrder
        orderProduct.idProduct = idProduct
        orderProduct.quantity = Int16(quantity)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save the product \(error)")
        }
    }
    
    func allOrderProducts() -> [OrderProduct] {
        let fetchRequest: NSFetchRequest<OrderProduct> = OrderProduct.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteOrderProduct(orderProduct: OrderProduct) {
        CoreDataManager.persistentContainer.viewContext.delete(orderProduct)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func createGroupsProduct(idGroup: UUID, idProduct: UUID) {
        let grousProduct = GroupsProduct(context: context)
        grousProduct.idGroup = idGroup
        grousProduct.idProduct = idProduct
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            print("Fail to save the product \(error)")
        }
    }
    
    func allGroupsProduct() -> [GroupsProduct] {
        let fetchRequest: NSFetchRequest<GroupsProduct> = GroupsProduct.fetchRequest()
        do {
            return try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteGroupsProduct(grousProduct: GroupsProduct) {
        CoreDataManager.persistentContainer.viewContext.delete(grousProduct)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
        } catch {
            CoreDataManager.persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
}
