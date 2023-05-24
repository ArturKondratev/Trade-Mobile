//
//  Router.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 16.05.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assamblyBuilder: AssamblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showOnboardingViewController()
    func showTraidingViewController()
    func showChoocePairViewController(navVC: UINavigationController)
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var tradeNavController: UINavigationController?
    var assamblyBuilder: AssamblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assamblyBuilder: AssamblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assamblyBuilder = assamblyBuilder
    }
    
    func initialViewController() {
        if UserDefaults.standard.bool(forKey: KeyConstants.isLogin) {
            showTraidingViewController()
        } else {
            showOnboardingViewController()
        }
    }
    
    func showOnboardingViewController() {
        if let navigationController = navigationController {
            guard let onboardingVC = assamblyBuilder?.craeteOnboardingModul(router: self) else { return }
            navigationController.viewControllers = [onboardingVC]
        }
    }
    
    func showTraidingViewController() {
        if let navigationController = navigationController {
            guard let traidingVC = assamblyBuilder?.createTraidingModul(router: self) else { return }
            navigationController.viewControllers = [traidingVC]
            navigationController.isNavigationBarHidden = true
        }
    }
    
    func showChoocePairViewController(navVC: UINavigationController) {
        self.tradeNavController = navVC
        guard let chooseVC = assamblyBuilder?.createCoosePairModul(router: self) else { return }
        navVC.pushViewController(chooseVC, animated: true)
    }
    
    func popToRoot() {
        if let tradeNavController = tradeNavController {
            tradeNavController.popViewController(animated: true)
        }
    }
}
