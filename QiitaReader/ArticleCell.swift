//
//  ArticleCell.swift
//  QiitaReader
//
//  Created by Takuya Matsuda on 2018/03/26.
//  Copyright © 2018年 mycompany. All rights reserved.
//

import UIKit
import TagListView

class ArticleCell: UITableViewCell, TagListViewDelegate {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var goodCnt: UILabel!
    @IBOutlet weak var authorIcon: UIImageView!
    @IBOutlet weak var readLaterButton: UIButton!
    @IBOutlet weak var tagListView: TagListView!
    var delegate: ArticleCellDelegate? = nil
    
    @IBAction func readLaterButtonTapped(_ sender: Any) {
        delegate?.addReadLater(cell: self)
    }
}





