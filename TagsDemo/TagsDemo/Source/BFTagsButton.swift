//
//  BFTagsButton.swift
//  TagsDemo
//
//  Created by midland on 2019/3/27.
//  Copyright © 2019年 HJQ. All rights reserved.
//

import UIKit

class BFTagsButton: UIButton {
    
    var model: BFTagsModel!
    
    var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    // cancle hightlighted
    override var isHighlighted: Bool {
        set{}
        get { return false }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentEdgeInsets = insets
    }
}
