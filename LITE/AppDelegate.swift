//
//  AppDelegate.swift
//  LITE
//
//  Created by Kenichi Saito on 4/22/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import UIKit
import GlidingCollection

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var config = GlidingConfig.shared
        config.buttonsFont = UIFont.init(name: "Avenir-Black", size: 17)!
        config.activeButtonColor = .black
        config.inactiveButtonsColor = .lightGray
        config.sideInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        config.animationDuration = 0.4
        config.cardsSpacing = 12
        let width = UIScreen.main.bounds.width - 36
        config.cardsSize = CGSize(width: round(width), height: round(width))
        GlidingConfig.shared = config
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

