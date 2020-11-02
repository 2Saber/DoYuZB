//
//  CollectionGameViewCell.swift
//  DYZB
//
//  Created by saber on 2020/11/1.
//

import UIKit
import Kingfisher

class CollectionGameViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var model : Group? {
        didSet{
            let imgURL = URL(string: model?.small_icon_url ?? "")
            iconImage.kf.setImage(with: imgURL, placeholder: UIImage(named: "home_more_btn"))
            titleLabel.text = model?.tag_name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
