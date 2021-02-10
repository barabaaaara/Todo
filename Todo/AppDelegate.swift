//
//  AppDelegate.swift
//  Todo
//
//  Created by 桑原佑輔 on 2021/02/10.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
//   control + I で整列
        print("起動した")
        // Override point for customization after application launch.
        return true
    }




}
