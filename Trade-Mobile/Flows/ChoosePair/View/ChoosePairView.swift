//
//  ChoosePairView.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 15.05.2023.
//

import UIKit

class ChoosePairView: UIView {
    
    // MARK: - Subviews
    private(set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 21
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ChoosePairCell.self, forCellWithReuseIdentifier: ChoosePairCell.reuseId)
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addCollectionView()
    }
    
    // MARK: - UI
    func addCollectionView() {
        backgroundColor = .brandBackround
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 37),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -37),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
