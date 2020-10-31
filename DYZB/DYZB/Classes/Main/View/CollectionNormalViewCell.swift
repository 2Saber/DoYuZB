//
//  CollectionNormalViewCell.swift
//  DYZB
//
//  Created by saber on 2020/10/30.
//

import UIKit
import Kingfisher

class CollectionNormalViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var onlineLabe: UIButton!
    @IBOutlet weak var nickNameLabe: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    var model : RoomModel? {
        didSet{
            guard let model = model else {
                return
            }
            var onlineStr : String = ""
            if model.online >= 10000{
                onlineStr = "\(model.online / 10000)万人"
            }else {
                onlineStr = "\(model.online) 人"
            }
            onlineLabe.setTitle(onlineStr, for: .normal)
            nickNameLabe.text = model.nickname
            roomLabel.text = model.room_name
            guard let iconURL = URL(string: model.vertical_src) else {
                return
            }
            image.kf.setImage(with: iconURL)
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
