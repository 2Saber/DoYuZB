//
//  CollectionCycleViewCell.swift
//  DYZB
//
//  Created by saber on 2020/11/1.
//

import UIKit
import SnapKit
import Kingfisher

class CollectionCycleViewCell: UICollectionViewCell {
    var model : CycleModel? {
        didSet{
            titleLabel.text = model?.title
            let iconURL = URL(string: model?.pic_url ?? "")
            imageView.kf.setImage(with: iconURL)
        }
    }
    fileprivate let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "13456"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    fileprivate let shadowView : UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.3)
        return shadowView
    }()
    fileprivate let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Img_default")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        shadowView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(30)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(shadowView.snp_centerY)
        }
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
}

fileprivate extension CollectionCycleViewCell {
    func setUp() {
        addSubview(imageView)
        addSubview(shadowView)
        shadowView.addSubview(titleLabel)
    }
    
}
