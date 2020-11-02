//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by saber on 2020/10/30.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    var model: Group? {
        didSet{
            titleLabel.text = model?.tag_name
            iconImageView.image = UIImage(named: model?.icon_name ?? "home_header_normal")
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }
    
}
