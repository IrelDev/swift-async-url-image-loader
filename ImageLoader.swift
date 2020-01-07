//
//  ImageLoader.swift
//
//  Created by Kirill Pustovalov on 07.01.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import UIKit
class ImageLoader: UIImageView {
    func setImage(stringUrlToImage: String?) {
        guard let stringUrlToImage = stringUrlToImage, let urlToImage = URL(string: stringUrlToImage) else { return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: urlToImage)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        let urlSessionDataTask = URLSession.shared.dataTask(with: urlToImage) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.imageToCache(data: data, response: response)
                }
            }
        }
        urlSessionDataTask.resume()
    }
    
    private func imageToCache(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
