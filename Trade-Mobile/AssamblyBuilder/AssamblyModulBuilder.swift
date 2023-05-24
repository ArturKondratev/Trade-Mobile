//
//  AppBuilder.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 13.05.2023.
//

import UIKit

protocol AssamblyBuilderProtocol {
    
}

class AssamblyModulBuilder {
    
    var navigatinController: UINavigationController
  
    init(navigetinController: UINavigationController) {
        self.navigatinController = navigetinController
    }
    
    func startApp(){
        if UserDefaults.standard.bool(forKey: "IsLogin" ) {
            goToTrade()
        } else {
            goToOnboarding()
        }
    }
    
    func goToOnboarding() {
        let vc = OnboardingBuilder.createModul(coordinator: self)
        navigatinController.pushViewController(vc, animated: true)
    }
    
    func goToTrade() {
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.backgroundColor = .brandTabBar
        tabBarVC.tabBar.barTintColor = .brandTabBar
        tabBarVC.tabBar.tintColor = .brandGreen
        
        let tradeVC = UINavigationController(rootViewController: TradeViewController())
        tradeVC.title = "Trade"
        
        let topVC = UINavigationController(rootViewController: Top10Builder.build())
        topVC.title = "Top"

        tabBarVC.setViewControllers([tradeVC, topVC], animated: true)
        
        let images = ["trade", "top"]
        if let items = tabBarVC.tabBar.items {
            for x in 0..<items.count {
                items[x].image = UIImage(named: images[x])
            }
        }
        navigatinController.pushViewController(tabBarVC, animated: true)
        navigatinController.navigationBar.isHidden = true
    }
}
