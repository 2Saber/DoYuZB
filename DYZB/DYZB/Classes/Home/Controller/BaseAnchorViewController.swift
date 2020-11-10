//
//  BaseViewController.swift
//  DYZB
//
//  Created by saber on 2020/11/2.
//

import UIKit

fileprivate let kItemMargin: CGFloat = 10
fileprivate let kHeaderViewH: CGFloat = 50
fileprivate let kNormalItemH = kNormalItemW * 3 / 4
fileprivate let kPrettyItemH = kNormalItemW * 4 / 3

fileprivate let kNormalItemW: CGFloat = (kScreenW - 3*kItemMargin)*0.5

fileprivate let kNormakCellID = "kNormakCellID"
fileprivate let kPrettyCellID = "kPrettyCellID"
fileprivate let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: UIViewController {
    //MARK: 定义属性
    var baseVM: BaseViewModel!
    
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionNormalViewCell", bundle: nil), forCellWithReuseIdentifier: kNormakCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadData()
    }
}

extension BaseAnchorViewController {
    @objc func setUp() {
        self.view.addSubview(collectionView)
    }
}
extension BaseAnchorViewController{
    @objc func loadData() {
        
    }
}


//MARK:-delegagte
extension BaseAnchorViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int { baseVM.totalModel.count  }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.totalModel[section].room_list?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormakCellID, for: indexPath) as! CollectionNormalViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.model = baseVM.totalModel[indexPath.section]
        return headerView
    }

}
