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
        let tmp = UIWindow(frame: UIScreen.main.bounds)
        window? = tmp
//        window? = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = TabbarViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

