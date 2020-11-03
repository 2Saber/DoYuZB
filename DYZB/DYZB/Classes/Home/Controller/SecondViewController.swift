//
//  SecondViewController.swift
//  DYZB
//
//  Created by saber on 2020/10/29.
//

import UIKit

fileprivate let kEdgeMargin : CGFloat = 10
fileprivate let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
fileprivate let kItemH : CGFloat = kItemW * 6 / 5

fileprivate let gameID = "gameID"
class SecondViewController: BaseAnchorViewController {
    lazy fileprivate var gameVM: Group = Group()

}
extension SecondViewController {
    override func setUp() {
        super.setUp()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        collectionView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: gameID)
        
    }
}
extension SecondViewController{
    override func loadData() {
        
    }
}

//MARK:-delegate
extension SecondViewController{

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameID, for: indexPath) as! CollectionGameViewCell
        cell.backgroundColor = UIColor.arc4random_color()
        return cell
    }
    
    
}

