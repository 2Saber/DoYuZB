//
//  FirstViewController.swift
//  DYZB
//
//  Created by saber on 2020/10/29.
//

import UIKit
fileprivate let kCycleViewH = kScreenW * 3 / 8
fileprivate let kGameViewH : CGFloat = 90
fileprivate let kItemMargin: CGFloat = 10
fileprivate let kNormalItemH = kNormalItemW * 3 / 4
fileprivate let kPrettyItemH = kNormalItemW * 4 / 3

fileprivate let kNormalItemW: CGFloat = (kScreenW - 3*kItemMargin)*0.5
fileprivate let kNormakCellID = "kNormakCellID"
fileprivate let kPrettyCellID = "kPrettyCellID"

class FirstViewController: BaseAnchorViewController {
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var collectCycleView: RecommenCycleView = {
        RecommenCycleView.init(frame: CGRect(x: 0, y: -kCycleViewH - kGameViewH, width: kScreenW, height: kCycleViewH))
    }()
    fileprivate lazy var collectGameView : RecommendGameView = {
        let collectGameView = RecommendGameView(frame: CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH))
        return collectGameView
    }()
}
//MARK:- setupUI
extension FirstViewController {
    override func setUp() {
        super.setUp()
        collectionView.addSubview(collectCycleView)
        collectionView.addSubview(collectGameView)
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: kGameViewH + kCycleViewH, left: 0, bottom: 0, right: 0)
    }
}
extension FirstViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyViewCell
            cell.model = (recommendVM.totalModel[indexPath.section].room_list![indexPath.row] as? RoomModel)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormakCellID, for: indexPath) as! CollectionNormalViewCell
            cell.model = (recommendVM.totalModel[indexPath.section].room_list![indexPath.row] as? RoomModel)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }else {
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    }
}

extension FirstViewController {
    override func loadData()  {
        baseVM = recommendVM
        recommendVM.requeCycyleDaga(modle: CycleModel.self) {
            self.collectCycleView.models = self.recommendVM.cycleModels
        }
        recommendVM.requestData(model: RoomModel.self ) {
            self.collectionView.reloadData()
            self.collectGameView.models = self.recommendVM.totalModel
        }
    }
}

