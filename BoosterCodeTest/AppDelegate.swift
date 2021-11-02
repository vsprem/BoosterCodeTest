//
//  AppDelegate.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 29.10.2021..
//

import UIKit

@main
public class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
        mainCoordinator.start()
        
        return true
    }
}

