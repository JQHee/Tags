//
//  BFTagsView.swift
//  TagsDemo
//
//  Created by HJQ on 2019/3/24.
//  Copyright © 2019 HJQ. All rights reserved.
//

import UIKit
import Foundation

protocol BFTagsViewDelegate: class {
    func itemClick(tagsView: BFTagsView, model: BFTagsModel)
}

class BFTagsView: UIView {

    var itemHeightCallBack:((_ heigt: CGFloat) -> ())?

    private lazy var tags: [BFTagsModel] = []
    private lazy var style: BFTagsStyle = BFTagsStyle()
    private var height: CGFloat = 0

    weak var delegate: BFTagsViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        height = frame.size.height
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        reload()
    }

    // MARK: - Public methods
    func show(tags: [BFTagsModel], style: BFTagsStyle = BFTagsStyle()) {
        self.tags = tags
        self.style = style
        reload()
    }

    func reload() {
        reload(tags: self.tags)
    }
    private func reload(tags: [BFTagsModel]) {
        subviews.forEach { (tempView) in
            tempView.removeFromSuperview()
        }
        var startX: CGFloat = style.leftSpace
        var startY: CGFloat = style.topSpace
        var lastWidth: CGFloat = 0
        var tempSpace: CGFloat  = 0
        for (_, value) in tags.enumerated() {
            let label = BFTagsLabel()
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            label.insets = value.insets
            label.font = style.font
            label.layer.masksToBounds = true
            label.layer.cornerRadius = value.corners

            if value.is_select {
                label.textColor = value.selectTextColor
                label.backgroundColor = value.selectBackgroundColor
                label.layer.borderColor = value.selectBothColor.cgColor
            } else {
                label.textColor = value.textColor
                label.backgroundColor = value.backgroundColor
                label.layer.borderColor = value.bothColor.cgColor
            }
            label.text = value.name
            label.model = value
            // tag action
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(itemTapAction(tapGes:)))
            label.addGestureRecognizer(tapGes)
            var width = widthForComment(text: value.name, font: style.font, height: style.itemHeight) + value.insets.left + value.insets.right
            let pWidth = frame.size.width
            if style.column != 0 {
                // average
                let totalSpace = CGFloat(style.column - 1) * style.itemHSpace
                let itemWidth = (pWidth - style.leftSpace - style.rightSpace - totalSpace) / CGFloat(style.column)
                width = itemWidth

            } else {
                if width >= style.maxWidth && style.maxWidth != 0 {
                    width = style.maxWidth
                } else {
                    // Father is beyond control
                    if width >= pWidth {
                        width = pWidth - style.leftSpace - style.rightSpace
                    }
                }
            }
            // Need to wrap
            if (CGFloat)(startX + width + style.rightSpace) > pWidth {
                startX = style.leftSpace
                startY += style.itemVSpace + style.itemHeight
                tempSpace = style.itemHSpace
                lastWidth = width

            } else {
                lastWidth = width
                tempSpace = style.itemHSpace
            }
            label.frame = CGRect.init(x: startX, y: startY, width: width, height: style.itemHeight)
            addSubview(label)
            startX = (CGFloat)(startX + lastWidth + tempSpace)
        }
        height = startY + style.bottomSpace + style.itemHeight
        if let _ = itemHeightCallBack {
            itemHeightCallBack!(getHeight())
        }
    }

    func getHeight() -> CGFloat {
        return height
    }

    @objc
    func itemTapAction(tapGes: UIGestureRecognizer) {
        guard let label = tapGes.view as? BFTagsLabel else {
            return
        }
        if let _ = delegate {
            delegate?.itemClick(tagsView: self, model: label.model)
        }
    }

    private func widthForComment(text: String, font: UIFont, height: CGFloat = 20) -> CGFloat {
        let font = font
        let rect = NSString(string: text).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }

}
