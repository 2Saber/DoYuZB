//
//  PageContView.swift
//  DYZB
//
//  Created by saber on 2020/10/29.
//

import UIKit

class PageContView: UIView {
    //MARK:属性
    fileprivate let collecID =  "collecID"
    fileprivate var childVCs: [UIViewController]
    fileprivate lazy var collectView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = bounds.size
        layout.scrollDirection = .horizontal
        
        let colletView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        colletView.showsHorizontalScrollIndicator = false
        colletView.isPagingEnabled = true
        colletView.bounces = true
        colletView.dataSource = self
        colletView.delegate = self
        colletView.scrollsToTop = false
        colletView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collecID)
        return colletView
    }()
    
    init(frame: CGRect, childVCs: [UIViewController], parentVC: BaseViewController) {
        self.childVCs = childVCs
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
//MARK:- setupUI
extension PageContView{
    func setup()  {
        addSubview(collectView)
    }
}

extension PageContView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectCell = collectionView.dequeueReusableCell(withReuseIdentifier: collecID, for: indexPath)
        collectView.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255))  , g: CGFloat(arc4random_uniform(255)) , b: CGFloat(arc4random_uniform(255)) , a: 1)
//        collectCell.backgroundColor = UIColor(r: arc4random(255), g: arc4random(255), b: arc4random(255), a: 1)
        return collectCell
    }
}
