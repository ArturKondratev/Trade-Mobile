//
//  TimerView.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 14.05.2023.
//

import UIKit

protocol TimerViewProtocol: AnyObject {
    func timerPlusButtonAction()
    func timerMinusButtonAction()
}

class TimerView: UIView {
    
    weak var delegate: TimerViewProtocol?
    
    //MARK: - Subviews
    lazy var timerLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Timer"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var timeLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "00:01"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tabTimerPlusButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tabTimerMinusButtonAction), for: .touchUpInside)
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
    @objc func tabTimerPlusButtonAction() {
        delegate?.timerPlusButtonAction()
    }
    
    @objc func tabTimerMinusButtonAction() {
        delegate?.timerMinusButtonAction()
    }
    
    // MARK: - UI
    func addViews() {
        backgroundColor = .brandGrey
        layer.cornerRadius = 12
        clipsToBounds = true
        
        addSubview(timerLable)
        addSubview(stackView)
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(timeLable)
        stackView.addArrangedSubview(plusButton)
        
        NSLayoutConstraint.activate([
            timerLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerLable.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
