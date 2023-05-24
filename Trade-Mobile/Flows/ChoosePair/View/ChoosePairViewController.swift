//
//  ChoosePairViewController.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 15.05.2023.
//

import UIKit

class ChoosePairViewController: UIViewController, ChoosePairViewProtocol {
    
    var presenter: ChoosePairPresenterProtocol!
    private var choosePairView: CoosePairView {
        return self.view as! CoosePairView
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = CoosePairView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choosePairView.collectionView.delegate = self
        choosePairView.collectionView.dataSource = self
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .brandBackround
    }
    
    //MARK: - Functions
    func reloadData() {
        choosePairView.collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ChoosePairViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.pair.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoosePairCell.reuseId, for: indexPath) as? CoosePairCell else { return UICollectionViewCell() }
        cell.configure(pair: presenter.pair[indexPath.row].name)
        if indexPath.row == 1 {
            cell.pairButton.backgroundColor = .brandGreen
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectPair(pair: presenter.pair[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 21,
                      height: 74)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
    }
}
