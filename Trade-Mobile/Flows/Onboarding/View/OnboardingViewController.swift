//
//  OnboardingViewController.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 12.05.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var presenter: OnboardingPresenterProtocol!
    
    // MARK: - Private Properties
    private var onboardingView: OnboardingView {
        return self.view as! OnboardingView
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = OnboardingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.delegate = self
        presenter.viewDidLoad()
    }
}

extension OnboardingViewController: OnboardingViewDelegate, OnboardingViewProtocol {
    
    //MARK: - OnboardingViewDelegate
    func didTabContinueButton() {
        presenter.continueButtonAction()
    }
    
    //MARK: - OnboardingViewProtocol

    func updateProgress(progress: Float, progressState: Int) {
        onboardingView.progressView.setProgress(progress, animated: true)
        onboardingView.progressLable.text = progressState.description + "%"
    }
    
    func showData() {
        onboardingView.progressView.isHidden = true
        onboardingView.progressLable.isHidden = true
        onboardingView.titleLable.isHidden = false
        onboardingView.continueButton.isHidden = false
    }
}
