//
//  ImageLoader.swift
//  Test Task App
//
//  Created by Dmytro Nechuyev on 29.04.2021.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    var downloadedImage: UIImage?
    var redirectedURL: URL?
    let didChange = PassthroughSubject<ImageLoader?, Never>()
    
    func  load(url: String) {
        
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            
            guard let data = data, let response = response, error == nil else {
                DispatchQueue.main.async {
                    self.didChange.send(nil)
                }
                return
            }
            
            self.downloadedImage = UIImage(data: data)
            self.redirectedURL = response.url
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
            
        }.resume()
    }
}
