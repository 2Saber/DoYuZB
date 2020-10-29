//
//  AppDelegate.swift
//  DYZB
//
//  Created by saber on 2020/10/28.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = TabbarViewController()
        window?.makeKeyAndVisible()
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = .orange
        return true
        
        
    }
}


