//
//  BFTagsModel.swift
//  
//
//  Created by HJQ on 2019/3/25.
//  Copyright © 2019 HJQ. All rights reserved.
//

import UIKit

class BFTagsModel {

    var name: String = ""
    var id: String = ""
    var is_select: Bool = false
    
    var corners: CGFloat = 5
    var borderWidth: CGFloat = 0
    var borderColor: UIColor = UIColor.clear
    var textColor: UIColor = UIColor.white
    var backgroundColor: UIColor = UIColor.orange
    var image: UIImage?
    var backgroudImage: UIImage?
    var rightBottomIcon: UIImage?

     var selectBorderColor: UIColor = UIColor.clear
    var selectTextColor: UIColor = UIColor.white
    var selectBackgroundColor: UIColor = UIColor.clear
    var selectImage: UIImage?
    var selectBackgroudImage: UIImage?
    var selectRightBottomIcon: UIImage?
    
    var numberOfLines: Int = 1
    var lineBreakMode: NSLineBreakMode = .byCharWrapping
    var textAlignment: NSTextAlignment = .center
    
    var rightIconSize = CGSize.init(width: 16, height: 16)

    var insets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 3, bottom: 0, right: 3)

    init(name: String) {
        self.name = name
    }

    init(name: String, id: String, isSelect: Bool = false) {
        self.name = name
        self.id = id
        self.is_select = isSelect
    }

}
