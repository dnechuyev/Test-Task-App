//
//  CoreDataController.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 28.04.2021.
//

import Foundation
import CoreData

class CoreDataController {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataController()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getAllWorkers() -> [WorkerEntity] {
        
        let request: NSFetchRequest<WorkerEntity> = WorkerEntity.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Test_Task_App")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
    
}
