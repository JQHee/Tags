//
//  BFTagsLabel.swift
//  TagsDemo
//
//  Created by HJQ on 2019/3/24.
//  Copyright © 2019 HJQ. All rights reserved.
//

import UIKit

class BFTagsLabel: UILabel {
    
    var model: BFTagsModel!

    var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    override  public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

}
