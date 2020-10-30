//
//  HomeViewController.swift
//  DYZB
//
//  Created by saber on 2020/10/28.
//

import UIKit
let kTitleViewH : Double = 40
class HomeViewController: BaseViewController { 
    lazy fileprivate var pageTitleView: PageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH + kNavbarH, width: Double(kScreenW), height: kTitleViewH)
        let pageTitleView = PageTitleView(frame: frame, titles: ["推荐", "游戏", "娱乐", "趣玩"])
        pageTitleView.deleget = self
        return pageTitleView
    }()
    lazy fileprivate var pageContView: PageContView  = { [weak self] in
        let frame = CGRect(x: 0, y: kTitleViewH + kStatusBarH + kNavbarH, width: Double(kScreenW), height: Double(kScreenH) - kTabBarH - kStatusBarH - kNavbarH - kTitleViewH )
        var childVCs = [FirstViewController(), SecondViewController(), ThiredViewController(), FourthViewController()]
        let pageContView = PageContView(frame: frame, childVCs: childVCs, parentVC: self!)
        pageContView.delegate = self
        return pageContView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
}
fileprivate extension HomeViewController{
    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContView)
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem("logo")
        let size = CGSize(width: 20, height: 20)
        let historyItem = UIBarButtonItem("image_my_history", "Image_my_history_click", size)
        let searchItem = UIBarButtonItem("btn_search", "btn_search_clicked",size)
        let qrcodeItem = UIBarButtonItem("Image_scan", "Image_scan_click", size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
    
    
}
//MARK:-delegate
extension HomeViewController: pageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex currentIndx: Int) {
        pageContView.setCurrentItem(currentIndx)
    }
}
extension HomeViewController: pageContViewDelegate{
    func pageContView(PageContView: PageContView, sourIndex oldIndex: Int, trageIndex willIndx: Int, progress ration: CGFloat) {
        pageTitleView.setCurrentIndex(sourIndex: oldIndex, targeIndex: willIndx, progress: ration)
    }
    
}
