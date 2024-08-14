//
//  AppDelegate.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/02.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let config = Realm.Configuration(
//                schemaVersion: 3, // スキーマバージョンを更新
//                migrationBlock: { migration, oldSchemaVersion in
//                    if oldSchemaVersion < 2 {
//                        // すべての既存オブジェクトに対してマイグレーションを実行
//                        migration.enumerateObjects(ofType: MedicineDataModel.className()) { oldObject, newObject in
//                            // もし `textField` プロパティが Int 型から String 型に変更された場合
//                            if let oldIntValue = oldObject?["textField"] as? Int {
//                                newObject?["textField"] = String(oldIntValue)
//                            }
//                            
//                            // もし `customPickerTextField` プロパティが Int 型から String 型に変更された場合
//                            if let oldIntValue = oldObject?["customPickerTextField"] as? Int {
//                                newObject?["customPickerTextField"] = String(oldIntValue)
//                            }
//                            
//                            // `label` プロパティの初期化
//                            newObject?["label"] = newObject?["label"] as? String ?? ""
//                        }
//                    }
//                }
//            )
//
//                Realm.Configuration.defaultConfiguration = config

        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

