//
//  ChoosePairCell.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 15.05.2023.
//

import UIKit

class ChoosePairCell: UICollectionViewCell {
    
    static let reuseId = "CurrencyPairCell"
    
    //MARK: - SubViews
    lazy var pairlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
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
        pairlabel.text = nil
        backgroundColor = .brandGrey
    }
    
    //MARK: - Configure
    func configure(pair: String) {
        pairlabel.text = pair
    }
    
    //MARK: - UI
    func setUI() {
        contentView.addSubview(pairlabel)
        backgroundColor = .brandGrey
        layer.cornerRadius = 12
        clipsToBounds = true
        
        NSLayoutConstraint.activate([
            pairlabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            pairlabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
