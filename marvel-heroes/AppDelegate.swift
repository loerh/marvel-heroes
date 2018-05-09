//
//  AppDelegate.swift
//  marvel-heroes
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        return true
    }
    
    /**
     Sets up appearance throughout the app.
     */
    private func setupAppearance() {
        
        if let font =  UIFont(name: "HelveticaNeue", size: 14),
            let fontMedium = UIFont(name: "HelveticaNeue-Medium", size: 21) {
            
            /// Font for all labels in app
            UILabel.appearance().font = font
            
            /// Navigation bar
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().titleTextAttributes = [.font: fontMedium, .foregroundColor: UIColor.white]
            
            /// Search bar appearance
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = font
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.font: font.withSize(15)], for: .normal)
        }
    }
}

