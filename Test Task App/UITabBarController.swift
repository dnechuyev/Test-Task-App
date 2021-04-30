//
//  UITabBarController.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 29.04.2021.
//

import Foundation
import SwiftUI

struct Company: Identifiable {
    let id = UUID()
    var name: String
}

struct UITabBarController: View {
    
    @EnvironmentObject var newWorkerData: NewWorkerModel
    @State var showAddCompanyAlert = false
    
    //Временное решение пока нет сущности CompanyEntity в БД
    var companiesArr = [
        Company(name: "Apple"),
        Company(name: "Google"),
        Company(name: "IBM"),
        Company(name: "Tesla"),
        Company(name: "Microsoft")
    ]
    
    
    var body: some View {
        TabView{
            NavigationView{
                List(newWorkerData.workers, id: \.id){ worker in
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
                List(companiesArr, id: \.id){ company in
                    Text("\(company.name)")
                }
                .alert(isPresented: $showAddCompanyAlert,
                           TextAlert(title: "New company", message: "Enter new company", keyboardType: .numberPad) { result in
                            if let text = result {
                                // Whrite to DB here
                            }
                           })
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
            .environmentObject(NewWorkerModel())
    }
}
