//
//  OnboardingView.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 13.05.2023.
//

import UIKit

protocol OnboardingViewDelegate: AnyObject {
    func didTabContinueButton()
}

class OnboardingView: UIView {
    
    let cornerRadius: CGFloat = 123 / 2
    let shadowRadius: CGFloat = 150
    weak var delegate: OnboardingViewDelegate?
    
    //MARK: - Subviews
    lazy var greenBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brandGreen
        view.layer.cornerRadius = cornerRadius
        
        view.layer.shadowColor = UIColor.brandGreen.cgColor
        view.layer.shadowRadius = cornerRadius
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        return view
    }()
    
    lazy var redBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brandRed
        view.layer.cornerRadius = cornerRadius
        
        view.layer.shadowColor = UIColor.brandRed.cgColor
        view.layer.shadowRadius = cornerRadius
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        return view
    }()
        
    lazy var blureView: UIView = {
        let blureView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        blureView.translatesAutoresizingMaskIntoConstraints = false
        return blureView
    }()
    
    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Welcome"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        label.isHidden = true
        return label
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .brandGreen
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Activate NOW", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressTintColor = .brandGreen
        progress.trackTintColor = .darkGray
        progress.layer.cornerRadius = 12
        progress.clipsToBounds = true
        return progress
    }()
    
    lazy var progressLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "0%"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    //MARK: - Action
    @objc func buttonAction() {
        delegate?.didTabContinueButton()
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
    }
    
    // MARK: - UI
    func addViews() {
        backgroundColor = .brandBackround
        addSubview(greenBottomView)
        addSubview(redBottomView)
        addSubview(blureView)
        addSubview(titleLable)
        addSubview(continueButton)
        addSubview(progressView)
        addSubview(progressLable)
        
        NSLayoutConstraint.activate([
            greenBottomView.widthAnchor.constraint(equalToConstant: 123),
            greenBottomView.heightAnchor.constraint(equalToConstant: 123),
            greenBottomView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 193),
            greenBottomView.rightAnchor.constraint(equalTo: rightAnchor, constant: -21),
            
            redBottomView.widthAnchor.constraint(equalToConstant: 123),
            redBottomView.heightAnchor.constraint(equalToConstant: 123),
            redBottomView.topAnchor.constraint(equalTo: greenBottomView.bottomAnchor, constant: 88),
            redBottomView.leftAnchor.constraint(equalTo: leftAnchor, constant: 21),
            
            blureView.topAnchor.constraint(equalTo: topAnchor),
            blureView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blureView.rightAnchor.constraint(equalTo: rightAnchor),
            blureView.leftAnchor.constraint(equalTo: leftAnchor),
            
            titleLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleLable.rightAnchor.constraint(equalTo: rightAnchor, constant: -38),
            titleLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 38),
            
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -58),
            continueButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            continueButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            continueButton.heightAnchor.constraint(equalToConstant: 54),
            
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressView.leftAnchor.constraint(equalTo: leftAnchor, constant: 38),
            progressView.rightAnchor.constraint(equalTo: rightAnchor, constant: -38),
            progressView.heightAnchor.constraint(equalToConstant: 24),
            
            progressLable.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            progressLable.centerYAnchor.constraint(equalTo: progressView.centerYAnchor)
        ])
    }
}
