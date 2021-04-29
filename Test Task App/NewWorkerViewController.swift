//
//  ContentView.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 28.04.2021.
//

import SwiftUI

struct NewWorkerViewController: View {
    
    @StateObject private var newWorkerData = NewWorkerModel()
    
    @State private var showingErrorAlert = false
    @State private var showingAlert = false
    
    var body: some View {
        
        List(){
            ImageRow()
            TextRow(result: $newWorkerData.name, rowTitle: "Name")
            TextRow(result: $newWorkerData.surname, rowTitle: "Surname")
            BirthdayRow(result: $newWorkerData.birthday)
            CompanyRow(result: $newWorkerData.company)
            
            HStack{
                Spacer()
                Button("Save new worker"){
                    showingErrorAlert = false
                    if newWorkerData.checkNewWorkerData() {
                        newWorkerData.save()
                        showingAlert.toggle()
                    } else {
                        showingErrorAlert.toggle()
                        showingAlert.toggle()
                    }
                }.font(.title)
                .foregroundColor(.blue)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 17)
                            .stroke(Color.black, lineWidth: 3)
                )
                .alert(isPresented: $showingAlert){
                    if showingErrorAlert {
                        return Alert(title: Text("All fields must be filled!"), dismissButton: .default(Text("OK")))
                    } else {
                        return Alert(title: Text("New worker was successfully saved!"), dismissButton: .default(Text("OK")))
                    }
                }
                Spacer()
            }.padding(.vertical, 5)
        }
    }
}

struct NewWorkerViewController_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkerViewController()
            .previewDevice("iPhone 12 Pro Max")
    }
}

struct ImageRow: View {
    var body: some View{
        HStack{
            Text("Avatar")
                .font(.title)
            Spacer()
            Image(systemName: "photo")
                .resizable()
                .font(.largeTitle)
                .frame(width: 180, height: 160)
        }.padding(.bottom, 10)
    }
}

struct TextRow: View {
    @Binding var result: String
    var rowTitle: String
    
    var body: some View {
        HStack{
            Text("\(rowTitle):")
                .font(.title)
            TextField("\(rowTitle)", text: $result)
                .font(.title)
        }
    }
}

struct BirthdayRow: View {
    @Binding var result: Date
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 1910, month: 1, day: 1)
        let endComponents = DateComponents(year:2021, month: 12, day: 31)
        return calendar.date(from: startComponents)! ... calendar.date(from: endComponents)!
    }()
    
    var body: some View {
        HStack {
            DatePicker("Birthday:", selection: $result, in: dateRange, displayedComponents: [.date])
                .datePickerStyle(WheelDatePickerStyle())
                .font(.title)
        }
    }
    
}

struct CompanyRow: View {
    @Binding var result: String
    let companiesArr = ["Apple", "Google", "IBM", "Tesla", "Microsoft"]
    
    var body: some View {
        HStack{
            Picker( selection: $result, label: Text("Company:") ) {
                ForEach(0..<companiesArr.count) { index in
                    Text("\(companiesArr[index])").tag("\(companiesArr[index])")
                }
            }.pickerStyle(MenuPickerStyle())
            .font(.title)
            Text("\(result)")
                .font(.title)
        }
    }
}

