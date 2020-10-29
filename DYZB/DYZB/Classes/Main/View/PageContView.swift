//
//  PageContView.swift
//  DYZB
//
//  Created by saber on 2020/10/29.
//

import UIKit

protocol pageContViewDelegate : class {
    func pageContView()
}
class PageContView: UIView {
    //MARK:属性
    fileprivate let collecID =  "collecID"
    weak var delegate :pageContViewDelegate?
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
        colletView.bounces = false
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
//MARK:-delegate
extension PageContView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectCell = collectionView.dequeueReusableCell(withReuseIdentifier: collecID, for: indexPath)
//        collectView.backgroundColor =
        for view in collectCell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVC = self.childVCs[indexPath.row]
        
        childVC.view.frame = collectCell.contentView.bounds
        childVC.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255))  , g: CGFloat(arc4random_uniform(255)) , b: CGFloat(arc4random_uniform(255)) , a: 1)
        collectCell.contentView.addSubview(childVC.view)
        return collectCell
    }
}

//MARK:-外接接口
extension PageContView{
    func setCurrentItem(_ currentItem: Int)  {
        
    }
}
