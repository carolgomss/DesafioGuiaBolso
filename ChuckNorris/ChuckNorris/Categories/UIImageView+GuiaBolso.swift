//
//  UIImageView+GuiaBolso.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 09/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import UIKit

extension UIImageView {
    
    private var imageCache: NSCache<NSString, AnyObject> {
        let imageCache = NSCache<NSString, AnyObject>()
        return imageCache
    }
    
    func setImage(url: String) {
        guard let webURL = URL(string: url) else {
            fatalError()
        }
        if let cachedImage = imageCache.object(forKey: webURL.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            downloadImage(url: webURL)
        }
    }
    
    private func downloadImage(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                if error == nil {
                    guard let newImage = UIImage(data: data) else {
                        return
                    }
                    self?.saveCache(path: url.absoluteString, image: newImage)
                    self?.image = newImage
                }
            }
        }.resume()
    }
    
    private func saveCache(path: String, image: UIImage) {
        self.imageCache.setObject(image, forKey: path as NSString)
    }
}
