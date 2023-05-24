//
//  Top10Header.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 13.05.2023.
//

import UIKit

class Top10Header: UITableViewHeaderFooterView {
    
    static let identifier = "Top10Header"
    
    // MARK: - SubView
    lazy var greyBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brandGrey
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return view
    }()
    
    lazy var number = makeLable(text: "№")
    lazy var country = makeLable(text: "Сountry")
    lazy var name = makeLable(text: "Name")
    lazy var deposit = makeLable(text: "Deposit")
    lazy var profit = makeLable(text: "Profit")
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private func makeLable(text: String) -> UILabel {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = text
        lable.font = UIFont.boldSystemFont(ofSize: 12)
        lable.textColor = .systemGray2
        return lable
    }
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    // MARK: - UI
    private func setUI() {
        backgroundColor = .clear
        addSubview(greyBottomView)
        addSubview(stackView)
        stackView.addArrangedSubview(number)
        stackView.addArrangedSubview(country)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(deposit)
        stackView.addArrangedSubview(profit)
        
        NSLayoutConstraint.activate([
            greyBottomView.topAnchor.constraint(equalTo: topAnchor),
            greyBottomView.leftAnchor.constraint(equalTo: leftAnchor),
            greyBottomView.rightAnchor.constraint(equalTo: rightAnchor),
            greyBottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
}
