//
//  AppUtility.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 29.10.2021..
//

import UIKit

public struct AppUtility {
    
    public static var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}
