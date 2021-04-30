//
//  NewWorkerModel.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 28.04.2021.
//

import Foundation
import CoreData

class NewWorkerModel: ObservableObject {
    
    var imageURI = URL(string: "")
    var name: String = ""
    var surname: String = ""
    var birthday: Date = Date()
    @Published var company: String = ""
    @Published var workers: [WorkerViewModel] = []
    
    init(){
        getAllWorkers()
    }
    
    func checkNewWorkerData() -> Bool {
        if imageURI == URL(string: "") || name == "" || surname == "" || birthday >= Date() {
            return false
        } else {
            return true
        }
    }
    
    func getAllWorkers() {
        workers = CoreDataController.shared.getAllWorkers().map(WorkerViewModel.init)
    }
    
    func save() {
        
        let database = WorkerEntity(context: CoreDataController.shared.viewContext)
        database.image = imageURI
        database.name = name
        database.second_name = surname
        database.birthday = birthday
        database.company = company
        
        CoreDataController.shared.save()
    }
    
}

struct WorkerViewModel {
    
    let workerEntity: WorkerEntity
    
    var id: NSManagedObjectID {
        return workerEntity.objectID
    }
    
    var name: String {
        return workerEntity.name ?? ""
    }
    
    var surname: String {
        return workerEntity.second_name ?? ""
    }
    
    var imageURL: URL {
        return workerEntity.image ?? URL(string: "")!
    }
    
    var birthday: Date {
        return workerEntity.birthday ?? Date()
    }
    
    var company: String {
        return workerEntity.company ?? ""
    }
    
}
