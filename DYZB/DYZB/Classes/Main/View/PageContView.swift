//
//  PageContView.swift
//  DYZB
//
//  Created by saber on 2020/10/29.
//

import UIKit
fileprivate let collecID =  "collecID"

protocol pageContViewDelegate : class {
    func pageContView(PageContView: PageContView, sourIndex oldIndex: Int, trageIndex willIndx: Int, progress ration: CGFloat)
}
class PageContView: UIView {
    //MARK:属性
    fileprivate var sourceContX: CGFloat = 0
    fileprivate var curretnContX: CGFloat = 0
    fileprivate var isForbitDelegate: Bool = false
    weak var delegate :pageContViewDelegate?
    fileprivate var childVCs: [UIViewController]
    //MARK:懒加载
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
//        childVC.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255))  , g: CGFloat(arc4random_uniform(255)) , b: CGFloat(arc4random_uniform(255)) , a: 1)
        collectCell.contentView.addSubview(childVC.view)
        return collectCell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbitDelegate = false
        sourceContX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbitDelegate { return }
        curretnContX = scrollView.contentOffset.x
        var targIndex = 0
        var sourIndex = 0
        var progress: CGFloat = 0
        if sourceContX>curretnContX{//右滑
            targIndex = Int(curretnContX / bounds.width)
            sourIndex = targIndex + 1
            progress = CGFloat(sourIndex) - curretnContX/bounds.width
            // 完全滑过去了
            if sourceContX - curretnContX == bounds.width {
                sourIndex = targIndex
                progress = 1
            }
           
        }else{//左边滑
            sourIndex = Int(curretnContX / bounds.width)
            targIndex = sourIndex + 1
            progress = curretnContX/bounds.width - CGFloat(sourIndex)
            if targIndex >= childVCs.count {
                targIndex = sourIndex
            }
            // 完全滑过去了
            if curretnContX - sourceContX == bounds.width {
                targIndex = sourIndex
                progress = 1
            }
        }
        delegate?.pageContView(PageContView: self, sourIndex: sourIndex, trageIndex: targIndex, progress: progress)
    }
}



//MARK:-外接接口
extension PageContView{
    func setCurrentItem(_ currentItem: Int)  {
        isForbitDelegate = true
        
        let offsetX =  CGFloat(currentItem) * bounds.width
        collectView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
