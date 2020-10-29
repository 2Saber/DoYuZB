//
//  TabbarViewController.swift
//  DYZB
//
//  Created by saber on 2020/10/28.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBar.tintColor = .orange
//        tabBar.barTintColor = .white
        addChild("首页", "btn_home_selected", "btn_home_selected", type: HomeViewController.self)
        addChild("直播", "btn_column_normal", "btn_column_selected", type: ProfileViewController.self)
        addChild("关注", "btn_live_normal", "btn_live_selected", type: ProfileViewController.self)
        addChild("我的", "btn_user_normal", "btn_user_selected", type: ProfileViewController.self)
        
    }
}
extension TabbarViewController{
    func addChild(_ title: String, _ image: String, _ selectImage: String, type: BaseViewController.Type) {
        let child = NavigationViewController(rootViewController: type.init())
        child.tabBarItem.title = title
        child.tabBarItem.selectedImage = UIImage(named: selectImage)
        child.tabBarItem.image = UIImage(named: image)
        addChild(child)
    }
}
