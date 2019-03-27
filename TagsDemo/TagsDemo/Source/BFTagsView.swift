//
//  BFTagsView.swift
//
//
//  Created by HJQ on 2019/3/25.
//  Copyright © 2019 HJQ. All rights reserved.
//

import UIKit
import Foundation

protocol BFTagsViewDelegate: class {
    func itemClick(tagsView: BFTagsView, model: BFTagsModel)
}

class BFTagsView: UIView {

    var itemHeightCallBack:((_ heigt: CGFloat) -> ())?

    var tags: [BFTagsModel] = [] {
        didSet {
            reload()
        }
    }

    var _style: BFTagsStyle = BFTagsStyle()
    var style: BFTagsStyle! {
        set {
            _style = newValue
        }
        get {
            return _style
        }
    }
    private var height: CGFloat = 0

    weak var delegate: BFTagsViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        reload()
    }

    // MARK: - Public methods
    func reload() {
        reload(tags: self.tags)
    }
    
    // MARK: - Private methods
    private func reload(tags: [BFTagsModel]) {
        subviews.forEach { (tempView) in
            tempView.removeFromSuperview()
        }
        var startX: CGFloat = style.padding.left
        var startY: CGFloat = style.padding.top
        var lastWidth: CGFloat = 0
        var tempSpace: CGFloat  = 0
        for (_, value) in tags.enumerated() {
            let button = BFTagsButton()
            button.titleLabel?.lineBreakMode = value.lineBreakMode
            button.titleLabel?.textAlignment = value.textAlignment
            button.titleLabel?.numberOfLines = value.numberOfLines
            button.isUserInteractionEnabled = true
            button.insets = value.insets
            button.titleLabel?.font = style.font
            button.layer.masksToBounds = true
            button.layer.cornerRadius = value.corners

            if value.is_select {
                button.setTitleColor(value.selectTextColor, for: .normal)
                button.backgroundColor = value.selectBackgroundColor
                button.layer.borderColor = value.selectBothColor.cgColor
                button.setImage(value.selectImage, for: .normal)
                button.setBackgroundImage(value.selectBackgroudImage, for: .normal)
            } else {
                button.setTitleColor(value.textColor, for: .normal)
                button.backgroundColor = value.backgroundColor
                button.layer.borderColor = value.bothColor.cgColor
                button.setBackgroundImage(value.backgroudImage, for: .normal)
                button.setImage(value.image, for: .normal)
            }
            button.setTitle(value.name, for: .normal)
            button.model = value
            // tag action
            button.addTarget(self, action: #selector(itemClick(btn:)), for: .touchUpInside)
            var width = widthForComment(text: value.name, font: style.font, height: style.itemHeight) + value.insets.left + value.insets.right
            let pWidth = frame.size.width
            if style.column != 0 {
                // average
                let totalSpace = CGFloat(style.column - 1) * style.itemHSpace
                let itemWidth = (pWidth - style.padding.left - style.padding.right - totalSpace) / CGFloat(style.column)
                width = itemWidth

            } else {
                if width >= style.maxWidth && style.maxWidth != 0 {
                    width = style.maxWidth
                } else {
                    // Father is beyond control
                    if width >= pWidth {
                        width = pWidth - style.padding.left - style.padding.right
                    }
                }
            }

            // Need to wrap
            if (CGFloat)(startX + width + style.padding.right) > pWidth {
                startX = style.padding.left
                startY += style.itemVSpace + style.itemHeight
            }
            tempSpace = style.itemHSpace
            lastWidth = width
            button.frame = CGRect.init(x: startX, y: startY, width: width, height: style.itemHeight)
            addSubview(button)
            if value.is_select {
                if let _ = value.selectRightBottomIcon {
                    let iconImageView = UIImageView.init(image: value.selectRightBottomIcon)
                    iconImageView.frame = CGRect.init(x: button.frame.width - value.rightIconSize.width - value.bothWidth, y: button.frame.height - value.rightIconSize.height - value.bothWidth, width: value.rightIconSize.width, height: value.rightIconSize.height)
                    button.addSubview(iconImageView)
                }
            } else {
                if let _ = value.rightBottomIcon {
                    let iconImageView = UIImageView.init(image: value.rightBottomIcon)
                    iconImageView.frame = CGRect.init(x: button.frame.width - value.rightIconSize.width - value.bothWidth, y: button.frame.height - value.rightIconSize.height - value.bothWidth, width: value.rightIconSize.width, height: value.rightIconSize.height)
                    button.addSubview(iconImageView)
                }
            }
            startX = (CGFloat)(startX + lastWidth + tempSpace)
            height = button.frame.origin.y + button.frame.size.height + style.padding.bottom
        }
        // height = startY + style.padding.bottom + style.itemHeight
        if let _ = itemHeightCallBack {
            itemHeightCallBack!(height)
        }
    }

    private func widthForComment(text: String, font: UIFont, height: CGFloat = 20) -> CGFloat {
        let font = font
        let rect = NSString(string: text).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }

    // MARK: - Event reponse
    @objc
    func itemClick(btn: BFTagsButton) {
        if let _ = delegate {
            delegate?.itemClick(tagsView: self, model: btn.model)
        }
    }

}
