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
    
    var body: some View {
        TabView{
            NavigationView{
                List(appData.workers, id: \.id){ worker in
                    NavigationLink(destination: DetailWorkerView(name: worker.name, surname: worker.surname, imageURL: worker.imageURL, birthday: worker.birthday, company: worker.company)){
                    Text(worker.name)
                    Text(worker.surname)
                    }
                    
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
                List(appData.companies, id: \.id){ company in
                    Text("\(company.name)")
                }.alert(isPresented: $showAddCompanyAlert,
                        TextAlert(title: "New company", message: "Enter new company", keyboardType: .numberPad) { result in
                            if let text = result {
                                if text != "" {
                                    appData.companyName = text
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
