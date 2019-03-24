//
//  ViewController.swift
//  TagsDemo
//
//  Created by HJQ on 2019/3/24.
//  Copyright © 2019 HJQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tagView1: BFTagsView!
    @IBOutlet weak var tagView2: BFTagsView!
    @IBOutlet weak var tagView1HeightCons: NSLayoutConstraint!
    @IBOutlet weak var tagView2HeightCons: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tags1: [BFTagsModel] = [
            BFTagsModel(name: "1233"),
            BFTagsModel(name: "1233"),
            BFTagsModel(name: "1233"),
            BFTagsModel(name: "你好啊您好呀"),
            BFTagsModel(name: "你好啊您好呀"),
            BFTagsModel(name: "你好啊您好呀"),
            BFTagsModel(name: "你好啊您好呀"),
            BFTagsModel(name: "1233"),
            BFTagsModel(name: "你好啊您好呀你好啊您好呀你好啊您好呀你好啊您好呀你好啊您好呀"),
            BFTagsModel(name: "你好啊您好呀"),
            BFTagsModel(name: "你好啊您好呀")
        ]
        let style1 = BFTagsStyle()

       let tagView = BFTagsView.init(frame: CGRect.init(x: 20, y: 300, width: UIScreen.main.bounds.size.width - 40, height: 80))
        tagView.tags = tags1
        tagView.delegate = self
        view.addSubview(tagView)
        tagView.itemHeightCallBack = { [weak self](height) in
            guard let `self` = self else {return}
            tagView.frame.size.height = height
        }

        tagView1.show(tags: tags1, style: style1)
        tagView1.itemHeightCallBack = { [weak self](height) in
            guard let `self` = self else {return}
            self.tagView1HeightCons.constant = height
        }

        let model = BFTagsModel.init(name: "测试点击", id: "1")
        model.selectBackgroundColor = .red
        let tags2: [BFTagsModel] = [
            model,
            BFTagsModel(name: "1233"),
            BFTagsModel(name: "1233"),
            BFTagsModel(name: "你好啊您好呀"),
            BFTagsModel(name: "你好啊您好呀")
        ]
        let style2 = BFTagsStyle()
        style2.column = 4
        tagView2.delegate = self
        tagView2.show(tags: tags2, style: style2)
        tagView2.itemHeightCallBack = { [weak self](height) in
            guard let `self` = self else {return}
            self.tagView2HeightCons.constant = height
        }
    }


}

// MARK: - BFTagsViewDelegate
extension ViewController: BFTagsViewDelegate {
    func itemClick(tagsView: BFTagsView, model: BFTagsModel) {
        model.is_select = !model.is_select
        tagsView.reload()
    }
}

