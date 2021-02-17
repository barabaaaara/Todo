//
//  AppDelegate.swift
//  Todo
//
//  Created by 桑原佑輔 on 2021/02/10.
//

import UIKit
import RealmSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let version:UInt64 = 2
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        
        
        //realmのマイグレーション
        let config = Realm.Configuration(
          // スキーマバージョン設定
          schemaVersion: version,

          // 実際のマイグレーション処理　古いスキーマバージョンのRealmを開こうとすると自動的にマイグレーションが実行
          migrationBlock: { migration, oldSchemaVersion in
            // 初めてのマイグレーションの場合、oldSchemaVersionは0
            if (oldSchemaVersion < self.version) {
              // 変更点を自動的に認識しスキーマをアップデートする（ここで勝手にするから何も書かない）
            }
          })

        // デフォルトRealmに新しい設定適用
        Realm.Configuration.defaultConfiguration = config

        // Realmを開こうとしたときスキーマバージョンが異なれば、自動的にマイグレーションが実行
    _ = try! Realm()

        return true
    }

}


