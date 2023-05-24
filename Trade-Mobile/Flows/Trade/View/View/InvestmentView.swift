//
//  InvestmentView.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 14.05.2023.
//

import UIKit

protocol InvestmentViewProtocol: AnyObject {
    func investmentPlusButtonAction()
    func investmentMinusButtonAction()
}

class InvestmentView: UIView {
    
    weak var delegate: InvestmentViewProtocol?
    
    //MARK: - Subviews
    lazy var investmentLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Investment"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var currencyLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "1,000$"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tabPlusButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tabMinusButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    //MARK: - Action
    @objc func tabPlusButtonAction() {
        delegate?.investmentPlusButtonAction()
    }
    
    @objc func tabMinusButtonAction() {
        delegate?.investmentMinusButtonAction()
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
        backgroundColor = .brandGrey
        layer.cornerRadius = 12
        clipsToBounds = true
        
        addSubview(investmentLable)
        addSubview(stackView)
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(currencyLable)
        stackView.addArrangedSubview(plusButton)
        
        NSLayoutConstraint.activate([
            investmentLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            investmentLable.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
