//
//  UITabBarController.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 29.04.2021.
//

import Foundation
import SwiftUI

struct UITabBarController: View {
    
    @EnvironmentObject var appData: AppDataModel
    @State var showAddCompanyAlert = false
    
    func deleteWorker(at offsets: IndexSet) {
        
        offsets.forEach { index in
            let worker =  appData.workers[index]
            appData.deleteWorker(worker: worker)
        }
        
        appData.getAllWorkers()
        appData.getAllCompanies()
    }
    
    func deleteCompany(at offsets: IndexSet) {
        
        offsets.forEach { index in
            let company =  appData.companies[index]
            appData.deleteCompany(company: company)
        }
        
        appData.getAllCompanies()
        appData.getAllWorkers()
    }
    
    var body: some View {
        TabView{
            NavigationView{
                List{
                    ForEach(appData.workers, id: \.id){ worker in
                        NavigationLink(destination: DetailWorkerView(name: worker.name, surname: worker.surname, imageURL: worker.imageURL, birthday: worker.birthday, company: worker.company)){
                            Text(worker.name)
                            Text(worker.surname)
                        }
                    }.onDelete(perform: deleteWorker)
                    
                }.padding(.horizontal, -20)
                .navigationBarTitle("List")
                
                .navigationBarItems(
                    trailing:
                        NavigationLink(destination: NewWorkerViewController()) {
                            Text("Создать")
                        }
                )
            }.tabItem {
                Text("Сотрудники")
            }
            
            NavigationView{
                List{
                    ForEach(appData.companies, id: \.id){ company in
                        NavigationLink(destination: DetailCompanyView(id: company.id, in: CoreDataController.shared.viewContext)){
                            Text("\(company.name)")
                        }
                    }.onDelete(perform: deleteCompany)
                }.alert(isPresented: $showAddCompanyAlert,
                        TextAlert(title: "New company", message: "Enter new company", keyboardType: .numberPad) { result in
                            if let text = result {
                                appData.companyName = text
                                if appData.checkCompanyData() {
                                    appData.saveCompany()
                                    appData.getAllCompanies()
                                }
                            }
                        }
                )
                .navigationBarItems(
                    trailing:
                        Button("Создать"){
                            showAddCompanyAlert.toggle()
                        }
                )
            }.tabItem {
                Text("Компании")
            }
        }
    }
    
}

struct UITabBarController_Previews: PreviewProvider {
    static var previews: some View {
        UITabBarController()
            .previewDevice("iPhone 12 Pro Max")
            .environmentObject(AppDataModel())
    }
}
