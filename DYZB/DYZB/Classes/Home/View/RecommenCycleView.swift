//
//  RecommenCycleView.swift
//  DYZB
//
//  Created by saber on 2020/11/1.
//

import UIKit
import SnapKit
fileprivate let collectCycleID = "collectCycleID"
fileprivate let pageControlW:CGFloat = 40
fileprivate let pageControlMargin: CGFloat = 10
fileprivate let pageControlH: CGFloat = 27.5


class RecommenCycleView: UIView {
    
    var cycleTimer: Timer?
    var models: [CycleModel]? {
        didSet{
            collectView.reloadData()
            pageControl.numberOfPages = models?.count ?? 0
            
            //MARK:- 滚动到中间
            let indexPath = IndexPath(item: (models?.count ?? 0) * 10, section: 0)
            collectView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            delTimer()
            addTimer()
        }
    }
    fileprivate lazy var collectView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kScreenW, height: kCycleViewH)
        layout.scrollDirection = .horizontal
        let collectView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kCycleViewH), collectionViewLayout: layout)
        collectView.register(CollectionCycleViewCell.self, forCellWithReuseIdentifier: collectCycleID)
        collectView.isPagingEnabled = true
        collectView.showsHorizontalScrollIndicator = false
        collectView.backgroundColor = .white
        collectView.delegate =  self
        collectView.dataSource = self
        return collectView
    }()
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ))
        pageControl.tintColor = .gray
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.pageIndicatorTintColor = .white
//        pageControl.backgroundColor = .black
        return pageControl
    }()

    override func layoutSubviews() {
        pageControl.snp.makeConstraints { (make) in
            make.rightMargin.equalTo(pageControlMargin)
            make.bottomMargin.equalTo(0)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
fileprivate extension RecommenCycleView {
    func setUp() {
        addSubview(collectView)
        addSubview(pageControl)
    }
}

extension RecommenCycleView: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { (models?.count ?? 0) * 10000 }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: collectCycleID, for: indexPath) as! CollectionCycleViewCell
        cell.model = models![indexPath.row % (models?.count ?? 1)]
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentX = scrollView.contentOffset.x + 0.5 * collectView.bounds.width
        let currentIndex =  Int(currentX / collectView.bounds.width)
        self.pageControl.currentPage = currentIndex % (models?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addTimer()
    }
    
}

//MARK:-定时器
extension RecommenCycleView{
    func addTimer()  {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoop.Mode.common)
    }
    func delTimer()  {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc func scrollToNext()  {
        let netOffentX = collectView.contentOffset.x + collectView.bounds.width
        collectView.setContentOffset(CGPoint(x: netOffentX, y: 0), animated: true)
    }
}
