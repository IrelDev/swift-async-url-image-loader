# swift-image-loader
An intuitive url image loader using swift with cached response
```swift
import UIKit
class ImageLoader: UIImageView {
    func setImage(stringUrlToImage: String?) {
        guard let stringUrlToImage = stringUrlToImage, let urlToImage = URL(string: stringUrlToImage) else {
            return self.image = nil
        }
        
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
```
## Usage
Copy ImageLoader.swift into your project <br>

In Identity inspector of ImageView choose custom class ImageLoader <br>

Create IBOutlet and make sure that your IBOutlet conform to ImageLoader <br>
Call setImage method

```swift
@IBOutlet weak var imageView: ImageLoader!
 override func viewDidLoad() {
        super.viewDidLoad()
        imageView.setImage(stringUrlToImage: "stringUrlToImage")
    }
```
