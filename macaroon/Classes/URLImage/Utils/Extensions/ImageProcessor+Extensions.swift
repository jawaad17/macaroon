// Copyright © 2019 hipolabs. All rights reserved.

import Foundation
import Kingfisher

extension Array where Element == ImageProcessor {
    public func joined() -> ImageProcessor? {
        var imageProcessor: ImageProcessor?
        forEach { anImageProcessor in
            if let existingProcessor = imageProcessor {
                imageProcessor = existingProcessor |> anImageProcessor
            } else {
                imageProcessor = anImageProcessor
            }
        }
        return imageProcessor
    }
}

extension Array where Element == ImageProcessor? {
    public func compactJoined() -> ImageProcessor? {
        return compactMap { $0 }.joined()
    }
}
