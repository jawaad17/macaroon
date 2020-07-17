// Copyright © 2019 hipolabs. All rights reserved.

import Foundation
import SnapKit
import UIKit

open class DownloadableImageView: ImageView, URLImageLoadable {
    public var placeholderContainer: URLImagePlaceholderContainer? {
        return placeholderView
    }

    private lazy var placeholderView = DownloadableImagePlaceholderView()

    open func customizeAppearance(_ style: DownloadableImageStyling) {
        super.customizeAppearance(style)

        if let placeholder = style.placeholder {
            placeholderView.customizeAppearance(placeholder)
        }
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        placeholderView.prepareForReuse()
    }
}