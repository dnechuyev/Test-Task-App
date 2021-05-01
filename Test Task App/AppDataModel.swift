//
//  NewWorkerModel.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 28.04.2021.
//

import Foundation
import CoreData

class AppDataModel: ObservableObject {
    
    var imageURI = URL(string: "")
    var name: String = ""
    var surname: String = ""
    var birthday: Date = Date()
    var companyName: String = ""
    @Published var company: String = ""
    @Published var workers: [WorkerViewModel] = []
    @Published var companies: [CompanyViewModel] = []
    
    init(){
        getAllWorkers()
        getAllCompanies()
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
    
    func getAllCompanies() {
        companies = CoreDataController.shared.getAllCompanies().map(CompanyViewModel.init)
    }
    
    func saveWorker() {
        
        let database = WorkerEntity(context: CoreDataController.shared.viewContext)
        database.image = imageURI
        database.name = name
        database.second_name = surname
        database.birthday = birthday
        database.company = CompanyEntity(context: CoreDataController.shared.viewContext)
        database.company?.name = company
        
        CoreDataController.shared.save()
    }
    
    func saveCompany() {
        
        let database = CompanyEntity(context: CoreDataController.shared.viewContext)
        database.name = companyName
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
        return workerEntity.image ?? URL(string: "google.com")!
    }
    
    var birthday: Date {
        return workerEntity.birthday ?? Date()
    }
    
    var company:  String   {
        return workerEntity.company?.name ?? "No company added"
    }
    
}

struct CompanyViewModel {
    
    let companyEntity: CompanyEntity
    
    var id: NSManagedObjectID {
        return companyEntity.objectID
    }
    
    var name: String {
        return companyEntity.name ?? "No company added"
    }
}
