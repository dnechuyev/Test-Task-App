//
//  DetailWorkerView.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 30.04.2021.
//

import Foundation
import SwiftUI

struct DetailWorkerView: View {
    
    var workerArr = [String]()
    var name: String
    var surname: String
    var imageURL: URL
    var birthday: Date
    var company: String
    
    var body: some View {
        List(){
            DetailImageRow(url: imageURL)
            DetailTextRow(workerData: name, rowTitle: "Name")
            DetailTextRow(workerData: surname, rowTitle: "Surname")
            DetailTextRow(workerData: company, rowTitle: "Company")
            DetailBirthdayRow(WorkerBirthday: birthday)
    
        }
    }
    
}

struct DetailImageRow: View {
    
    @ObservedObject private var imageLoader = ImageLoader()

    init(url: URL){
        self.imageLoader.load(url: url.absoluteString)
    }
        
    var body: some View{
        HStack{
            if let image = self.imageLoader.downloadedImage {
                Text("Avatar")
                    .font(.title)
                Spacer()
                Image(uiImage: image)
                    .resizable()
                    .font(.largeTitle)
                    .frame(width: 180, height: 160)
            } else {
                Text("Avatar")
                    .font(.title)
                Spacer()
                Image(systemName: "photo")
                    .resizable()
                    .font(.largeTitle)
                    .frame(width: 180, height: 160)
            }
        }.padding(.bottom, 10)
    }
}

struct DetailTextRow: View {
    var workerData: String
    var rowTitle: String
    
    var body: some View {
        HStack{
            Text("\(rowTitle):")
                .font(.title)
            Text("\(workerData)")
                .font(.title)
        }
    }
}

struct DetailBirthdayRow: View {
    var WorkerBirthday: Date
    
    var body: some View {
        HStack{
            Text("Birthday:")
            Text(WorkerBirthday, style: .date)
        }
    }
}
