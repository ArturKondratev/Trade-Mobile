//
//  OnboardingPresenter.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 13.05.2023.
//

import UIKit

protocol OnboardingPresenterProtocol {
    init(view: OnboardingViewProtocol, router: RouterProtocol)
    func viewDidLoad()
    func continueButtonAction()
}

protocol OnboardingViewProtocol: AnyObject {
    func updateProgress(progress: Float, progressState: Int)
    func showData()
}

class OnboardingPresenter: OnboardingPresenterProtocol {
    
    //MARK: - Propertis
    weak var view: OnboardingViewProtocol?
    var router: RouterProtocol?
    
    private var myTimer: Timer?
    private var progress: Float = 0.0
    private var progressState: Int = 0
    
    //MARK: - Init
    required init(view: OnboardingViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Functions
    func viewDidLoad() {
        myTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                       target: self,
                                       selector: #selector(updateProgressBar),
                                       userInfo: nil,
                                       repeats: true)
    }
    
    @objc func updateProgressBar() {
        if progress < 1.0, progressState < 100 {
            progress += 0.01
            progressState += 1
            view?.updateProgress(progress: progress, progressState: progressState)
        } else {
            appIsLoaded()
            self.myTimer?.invalidate()
        }
    }
    
    func appIsLoaded() {
        view?.showData()
    }
    
    func continueButtonAction() {
        UserDefaults.standard.setValue(true, forKey: KeyConstants.isLogin)
        router?.showTraidingViewController()
    }
}
