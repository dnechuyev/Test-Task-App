//
//  DetailCompanyView.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 02.05.2021.
//

import Foundation
import SwiftUI
import CoreData

struct DetailCompanyView: View {
    
    @ObservedObject var company: CompanyEntity
    var error = false
    
    init(id: NSManagedObjectID, in context: NSManagedObjectContext){
        if let company = try? context.existingObject(with: id) as? CompanyEntity {
            self.company = company
        } else {
            self.company = CompanyEntity(context: context)
            self.error = true
        }
    }
    
    var body: some View {
        List{
            Section() {
                if let name = company.name {
                    Text("Name of company: \(name)")
                }
                if let employees = company.employees?.allObjects as? [WorkerEntity] {
                    Text("Amount of  employees: \(employees.count)")
                }
            }
            
            Section(header: Text("Company's employees")) {
                if let employees = company.employees?.allObjects as? [WorkerEntity] {
                    ForEach(employees, id: \.id){ employee in
                        Text("\(employee.name ?? "Got nil") \(employee.second_name ?? "Got nil") ")
                        
                    }
                }
            }
        }.navigationTitle("About company")
    }
}
