//
//  TradeView.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 14.05.2023.
//

import UIKit
import WebKit

protocol TradeViewActionProtocol: AnyObject {
    func didTabPairButton()
    func didTabSellBuyButton()
}

class TradeView: UIView {
    
    weak var delegate: TradeViewActionProtocol?
    
    //MARK: - Subviews
    lazy var greyBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brandGrey
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    lazy var balanceLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Balance"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .heavy)
        return label
    }()
    
    lazy var depositLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        // label.text = "10,000$"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    lazy var pairButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .brandGrey
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.tintColor = .white
        button.addTarget(self, action: #selector(pairButtonAction), for: .touchUpInside)
        
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "chevron.right",
                               withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.imagePlacement = .trailing
        config.imagePadding = 150.0
        config.titleAlignment = .center
        config.baseBackgroundColor = .brandGrey
        config.baseForegroundColor = .white
        button.configuration = config
        
        let attributedText = NSMutableAttributedString(string: "GPB/USD", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: 1
        ])
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    
    lazy var timerView: TimerView = {
        let view = TimerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var investmentView: InvestmentView = {
        let view = InvestmentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var sellButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .brandRed
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("SELL", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.tintColor = .white
        button.addTarget(self, action: #selector(sellBuyButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .brandGreen
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("BUY", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.tintColor = .white
        button.addTarget(self, action: #selector(sellBuyButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 11.0
        return stackView
    }()
    
    lazy var secendStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 11.0
        return stackView
    }()
    
    lazy var thirdStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
    }
    
    //MARK: - Action
    @objc func pairButtonAction() {
        delegate?.didTabPairButton()
    }
    @objc func sellBuyButtonAction() {
        delegate?.didTabSellBuyButton()
    }
    
    // MARK: - UI
    func addViews() {
        backgroundColor = .brandBackround
        addSubview(greyBottomView)
        addSubview(balanceLable)
        addSubview(depositLable)
        addSubview(webView)
        
        addSubview(firstStackView)
        firstStackView.addArrangedSubview(timerView)
        firstStackView.addArrangedSubview(investmentView)
        
        addSubview(secendStackView)
        secendStackView.addArrangedSubview(sellButton)
        secendStackView.addArrangedSubview(buyButton)
        
        addSubview(thirdStackView)
        thirdStackView.addArrangedSubview(pairButton)
        thirdStackView.addArrangedSubview(firstStackView)
        thirdStackView.addArrangedSubview(secendStackView)
        
        NSLayoutConstraint.activate([
            greyBottomView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            greyBottomView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            greyBottomView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            greyBottomView.heightAnchor.constraint(equalToConstant: 54),
            
            balanceLable.centerXAnchor.constraint(equalTo: greyBottomView.centerXAnchor),
            balanceLable.topAnchor.constraint(equalTo: greyBottomView.topAnchor, constant: 5),
            
            depositLable.centerXAnchor.constraint(equalTo: greyBottomView.centerXAnchor),
            depositLable.topAnchor.constraint(equalTo: balanceLable.bottomAnchor, constant: 7),
            
            webView.topAnchor.constraint(equalTo: greyBottomView.bottomAnchor, constant: 25),
            webView.leftAnchor.constraint(equalTo: leftAnchor),
            webView.rightAnchor.constraint(equalTo: rightAnchor),
            webView.heightAnchor.constraint(equalToConstant: 321),
            
            firstStackView.heightAnchor.constraint(equalToConstant: 54),
            secendStackView.heightAnchor.constraint(equalToConstant: 54),
            
            thirdStackView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 16),
            thirdStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            thirdStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            
            pairButton.widthAnchor.constraint(equalToConstant: thirdStackView.frame.width),
            pairButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}
