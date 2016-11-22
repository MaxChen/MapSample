//
//  AppDelegate.swift
//  MapRegion
//
//  Created by Max on 2016/11/22.
//  Copyright © 2016年 anvapp. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let manager = CLLocationManager()
    let schoolRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(25.01735, 121.539907), radius: 1000, identifier: "region")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            manager.requestAlwaysAuthorization()
        }
        manager.delegate = self
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    // 進入背景
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            print("開始監控")
            manager.stopUpdatingLocation()
            manager.startMonitoring(for: schoolRegion)
            manager.startMonitoringSignificantLocationChanges()
        }
        else {
            print("Region monitoring is not available")
        }
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // 停止監控
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            print("停止監控")
            manager.stopMonitoringSignificantLocationChanges()
            manager.startUpdatingLocation()
        }
        else {
            print("Region monitoring is not available")
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion 進入範圍！")
        print(region)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion 離開範圍！")
        print(region)
    }
    
}
