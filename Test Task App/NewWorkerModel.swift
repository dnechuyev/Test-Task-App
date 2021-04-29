//
//  NewWorkerModel.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 28.04.2021.
//

import Foundation
import CoreData

class NewWorkerModel: ObservableObject {
    
    var imageURI = URL(string: "https://google.com")
    var name: String = ""
    var surname: String = ""
    var birthday: Date = Date()
    @Published var company: String = ""
    
    func checkNewWorkerData() -> Bool {
        if imageURI == URL(string: "") || name == "" || surname == "" || birthday >= Date() {
            return false
        } else {
            return true
        }
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
