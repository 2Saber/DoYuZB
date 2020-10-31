//
//  CollectionPrettyViewCell.swift
//  DYZB
//
//  Created by saber on 2020/10/30.
//

import UIKit
import Kingfisher

class CollectionPrettyViewCell: UICollectionViewCell {
    var model: RoomModel?  {
        didSet{
            guard let model = model else {
                return
            }
            var online = ""
            if model.online >= 10000 {
                online = "\(model.online / 10000)万人"
            }else {
                online = "\(model.online)人"
            }
            onlineLabel.text = online
            guard let iconURL = URL(string: model.vertical_src) else {
                return
            }
            imageLabel.kf.setImage(with: iconURL)
            nickNameLabel.text = model.nickname
            cityBtn.setTitle(model.room_name, for: .normal)
        }
    }
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
