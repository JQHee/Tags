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
    var bothWidth: CGFloat = 0
    var bothColor: UIColor = UIColor.clear
    var textColor: UIColor = UIColor.white
    var backgroundColor: UIColor = UIColor.orange

    var selectBothColor: UIColor = UIColor.clear
    var selectTextColor: UIColor = UIColor.white
    var selectBackgroundColor: UIColor = UIColor.clear

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
