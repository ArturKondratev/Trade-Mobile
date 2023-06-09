//
//  Top10ViewCell.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 13.05.2023.
//

import UIKit

class Top10ViewCell: UITableViewCell {
    
    static let identifier = "Top10ViewCell"
    
    //MARK: - SubViews
    lazy var countryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "flag")
        return image
    }()
    
    lazy var number = makeLable(text: "№", color: .white)
    lazy var name = makeLable(text: "$336755", color: .white)
    
    lazy var deposit: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.textColor = .white
        lable.textAlignment = .right
        return lable
    }()
    
    lazy var profit: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.textColor = .brandGreen
        lable.textAlignment = .right
        return lable
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        return stackView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countryImage.image = nil
        number.text = nil
        name.text = nil
        deposit.text = nil
        profit.text = nil
    }
    
    func configure(trader: Trader) {
        name.text = trader.name
        deposit.text = "$" + trader.deposit.description
        profit.text = "$" + trader.profit.description
        countryImage.image = UIImage(named: trader.country)
    }
    
    func cofigureContentView() {
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    
    //MARK: - UI
    func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(number)
        stackView.addArrangedSubview(countryImage)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(deposit)
        stackView.addArrangedSubview(profit)
        
        NSLayoutConstraint.activate([
            countryImage.heightAnchor.constraint(equalToConstant: 20),
            countryImage.widthAnchor.constraint(equalToConstant: 32),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
}

private extension Top10ViewCell {
    private func makeLable(text: String, color: UIColor) -> UILabel {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = text
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.textColor = color
        return lable
    }
}

