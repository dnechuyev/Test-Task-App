//
//  ImageCollection.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 30.04.2021.
//

import Foundation
import SwiftUI

struct ImageCollectionView: View {
    
    @Binding var resultURL: URL?
    @Binding var resultUIImage: UIImage?
    let kittenURL = URL(string: "https://loremflickr.com/180/160")
    
    var body: some View {
        
        List {
            ForEach(0..<6) { items in
                HStack{
                    ForEach(0..<2) { item in
                        CollectionImageRow(url: kittenURL!, resultURL: $resultURL, resultUIImage: $resultUIImage)
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct CollectionImageRow: View {
    
    @Binding var resultURL: URL?
    @Binding var resultUIImage: UIImage?
    @ObservedObject private var imageLoader = ImageLoader()
    @Environment(\.presentationMode) var presentaionMode
    
    init(url: URL, resultURL: Binding<URL?>, resultUIImage: Binding<UIImage?>){
        self._resultURL = resultURL
        self._resultUIImage = resultUIImage
        self.imageLoader.load(url: url.absoluteString)
    }
    
    var body: some View{
        HStack{
            if let image = self.imageLoader.downloadedImage {
                Image(uiImage: image)
                    .resizable()
                    .font(.largeTitle)
                    .frame(width: 180, height: 160)
                    .onTapGesture {
                        if let picURL = imageLoader.redirectedURL {
                            resultURL = picURL
                        }
                        if let picUI = imageLoader.downloadedImage {
                            resultUIImage = picUI
                        }
                        self.presentaionMode.wrappedValue.dismiss()
                    }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .font(.largeTitle)
                    .frame(width: 180, height: 160)
            }
        }
    }
}
