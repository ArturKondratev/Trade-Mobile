//
//  CoosePairCell.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 15.05.2023.
//

import UIKit

class ChoosePairCell: UICollectionViewCell {
    
    static let reuseId = "CurrencyPairCell"
    
    //MARK: - SubViews
    lazy var pairButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .brandGrey
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("123", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pairButton.backgroundColor = .brandGrey
        pairButton.setTitle(nil, for: .normal)
    }
    
    //MARK: - Configure
    func configure(pair: String) {
        pairButton.setTitle(pair, for: .normal)
    }
    
    //MARK: - UI
    func setUI() {
        backgroundColor = .clear
        contentView.addSubview(pairButton)
        NSLayoutConstraint.activate([
            pairButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pairButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            pairButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            pairButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
