//
//  FirstViewController.swift
//  DYZB
//
//  Created by saber on 2020/10/29.
//

import UIKit

fileprivate let kItemMargin: CGFloat = 10
fileprivate let kHeaderViewH: CGFloat = 50
private let kNormalItemW: CGFloat = (kScreenW - 3*kItemMargin)*0.5
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

let kCycleViewH = kScreenW * 3 / 8
let kGameViewH : CGFloat = 90

fileprivate let kNormakCellID = "kNormakCellID"
fileprivate let kPrettyCellID = "kPrettyCellID"
fileprivate let kHeaderViewID = "kHeaderViewID"

class FirstViewController: UIViewController {
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        collectionView.register(UINib(nibName: "CollectionNormalViewCell", bundle: nil), forCellWithReuseIdentifier: kNormakCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    fileprivate lazy var collectCycleView: RecommenCycleView = {
        RecommenCycleView.init(frame: CGRect(x: 0, y: -kCycleViewH - kGameViewH, width: kScreenW, height: kCycleViewH))
    }()
    fileprivate lazy var collectGameView : RecommendGameView = {
        let collectGameView = RecommendGameView(frame: CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH))
        return collectGameView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadData()
    }

}
fileprivate extension FirstViewController {
    func setUp() {
        view.addSubview(collectionView)
        collectionView.addSubview(collectCycleView)
        collectionView.addSubview(collectGameView)
        
    }
}
extension FirstViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int { recommendVM.totalModel.count  }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.totalModel[section].room_list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyViewCell
            cell.model = recommendVM.totalModel[indexPath.section].room_list[indexPath.row]
//            cell.model
//                = recommendVM.totalModel[indexPath.section].room_list[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormakCellID, for: indexPath) as! CollectionNormalViewCell
            cell.model = recommendVM.totalModel[indexPath.section].room_list[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.model = recommendVM.totalModel[indexPath.section]
        return headerView
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
    func loadData()  {
        recommendVM.requeCycyleDaga(modle: CycleModel.self) {
            self.collectCycleView.models = self.recommendVM.cycleModels
        }
        recommendVM.requestData(model: RoomModel.self ) {
            self.collectionView.reloadData()
            self.collectGameView.models = self.recommendVM.totalModel
        }
    }
}

