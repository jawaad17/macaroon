// Copyright © 2019 hipolabs. All rights reserved.

import Foundation
import Kingfisher
import SnapKit
import UIKit

public class DownloadableImagePlaceholderView: BaseView, URLImagePlaceholderContainer {
    public var placeholder: ImagePlaceholder? {
        didSet {
            reloadData()
        }
    }

    public private(set) lazy var imageView = UIImageView()
    public private(set) lazy var textLabel = UILabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareLayout()
    }

    open func customizeAppearance(_ style: DownloadableImagePlaceholderStyling) {
        customizeBaseAppearance(style)

        imageView.contentMode = style.contentMode

        if let font = style.font?.normal {
            textLabel.customizeAppearance(font)
        }
        if let textColor = style.textColor?.normal {
            textLabel.textColor = textColor
        }
        textLabel.textAlignment = style.textAlignment

        textLabel.customizeAppearance(style.textOverflow)
    }

    open func prepareLayout() {
        addImageView()
        addTextLabel()
    }

    open func addImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
    }

    open func addTextLabel() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(8.0)
            maker.leading.equalToSuperview().inset(8.0)
            maker.bottom.equalToSuperview().inset(8.0)
            maker.trailing.equalToSuperview().inset(8.0)
        }
    }

    open func prepareForReuse() {
        imageView.image = nil
        textLabel.editText = nil
    }

    open func reloadData() {
        imageView.load(from: placeholder?.source)
        textLabel.editText = placeholder?.description
    }
}
