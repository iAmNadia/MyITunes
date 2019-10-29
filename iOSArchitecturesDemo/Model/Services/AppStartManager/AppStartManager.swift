//
//  AppStartConfigurator.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppStartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let rootVC = self.configuredTabBarController
        
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
    
    private lazy var configuredTabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        
        let searchAppsViewController = SearchModuleBuilder.build()
        searchAppsViewController.navigationItem.title = "Search Applications"
        searchAppsViewController.tabBarItem = UITabBarItem(title: "Applications", image: #imageLiteral(resourceName: "iconAppstore"), tag: 0)
        
        let searchSongsViewController = SearchModuleBuilder.build()
        searchSongsViewController.navigationItem.title = "Search Songs"
        searchSongsViewController.tabBarItem = UITabBarItem(title: "Songs", image: #imageLiteral(resourceName: "iconmusic"), tag: 1)
        
        let viewControllers = [searchAppsViewController, searchSongsViewController]
        tabBarController.viewControllers = viewControllers.map { buildNavigationController(with: $0) }
        return tabBarController
    }()
    
    private func buildNavigationController(with rootViewController: UIViewController) -> UINavigationController {
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.navigationBar.barTintColor = UIColor.varna
        navigationViewController.navigationBar.isTranslucent = false
        navigationViewController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationViewController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navigationViewController
    }
}
