//
//  RecommendGameView.swift
//  DYZB
//
//  Created by saber on 2020/11/1.
//

import UIKit
fileprivate let gameID = "gameID"
private let kEdgeInsetMargin : CGFloat = 20
fileprivate let kGameViewH : CGFloat = 90
class RecommendGameView: UIView {

    var models:[Group]? {
        didSet{
            models?.remove(at: 0)
            models?.remove(at: 0)
//            let tmpGroup = Group(tag_name: "更多")
            let tmpGroup = Group()
            models?.append(tmpGroup)
            collection.reloadData()
        }
    }
    fileprivate lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 90)
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kGameViewH), collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
        collection.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: gameID)
        return collection
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
fileprivate extension RecommendGameView {
    func setUp() {
        addSubview(collection)
    }
}
extension RecommendGameView : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: gameID, for: indexPath) as! CollectionGameViewCell
        cell.model = self.models?[indexPath.item]
        return cell
    }
    
    
}
