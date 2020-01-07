# swift-image-loader
An intuitive url image loader using swift with cached response
## Usage
Copy ImageLoader.swift into your project <br>
In Identity inspector of ImageView choose custom class ImageLoader <br>
Create IBOutlet and make sure that your IBOutlet conform to ImageLoader <br>
Call setImage method.

```swift
@IBOutlet weak var imageView: ImageLoader!
imageView.setImage(stringUrlToImage: "stringUrlToImage")
```
