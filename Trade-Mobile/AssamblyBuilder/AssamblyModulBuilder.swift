//
//  AssamblyModulBuilder.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 13.05.2023.
//

import UIKit

protocol AssamblyBuilderProtocol {
    func craeteOnboardingModul(router: RouterProtocol) -> UIViewController
    func createTraidingModul(router: RouterProtocol) -> UITabBarController
    func createCoosePairModul(router: RouterProtocol) -> UIViewController
}

class AssamblyModulBuilder: AssamblyBuilderProtocol {
    
    func craeteOnboardingModul(router: RouterProtocol) -> UIViewController {
        let view = OnboardingViewController()
        let presenter = OnboardingPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createTraidingModul(router: RouterProtocol) -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.backgroundColor = .brandTabBar
        tabBarVC.tabBar.barTintColor = .brandTabBar
        tabBarVC.tabBar.tintColor = .brandGreen
        
        let tradeVC = TradeViewController()
        let tradePresenter = TradeViewPresenter(view: tradeVC, router: router)
        tradeVC.presenter = tradePresenter
        let tradeNavControl = UINavigationController(rootViewController: tradeVC)
        
        let topVC = TopViewController()
        let topPresenter = TopPresenter(view: topVC, router: router)
        topVC.presenter = topPresenter
        let topNavControl = UINavigationController(rootViewController: topVC)
        topNavControl.navigationBar.barTintColor = .brandBackround
        
        tabBarVC.setViewControllers([tradeNavControl, topNavControl], animated: true)
        
        let images = ["Trade", "Top"]
        if let items = tabBarVC.tabBar.items {
            for x in 0..<items.count {
                items[x].image = UIImage(named: images[x])
                tabBarVC.viewControllers?[x].title = images[x]
            }
        }
        return tabBarVC
    }
    
    func createCoosePairModul(router: RouterProtocol) -> UIViewController {
        let view = ChoosePairViewController()
        let presenter = ChoosePairPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
