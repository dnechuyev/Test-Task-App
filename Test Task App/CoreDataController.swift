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
    
    func getAllCompanies() -> [CompanyEntity] {
        
        let request: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func getWorkerByID(id: NSManagedObjectID) -> WorkerEntity? {
        
        do {
            return try viewContext.existingObject(with: id) as? WorkerEntity
        } catch {
            return nil
        }
    }
    
    func getCompanyByID(id: NSManagedObjectID) -> CompanyEntity? {
        
        do {
            return try viewContext.existingObject(with: id) as? CompanyEntity
        } catch {
            return nil
        }
    }
    
    func deleteWorker(worker: WorkerEntity) {
        
        viewContext.delete(worker)
        save()
    }
    
    func deleteCompany(company: CompanyEntity) {
        
        viewContext.delete(company)
        save()
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
