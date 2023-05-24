//
//  ChoosePairViewController.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 15.05.2023.
//

import UIKit

class ChoosePairViewController: UIViewController, ChoosePairViewProtocol {
    
    var presenter: ChoosePairPresenterProtocol!
    private var choosePairView: ChoosePairView {
        return self.view as! ChoosePairView
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = ChoosePairView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choosePairView.collectionView.delegate = self
        choosePairView.collectionView.dataSource = self
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .brandBackround
        configNavBar()
        presenter.viewDidLoad()
    }
    
    //MARK: - Configure2
    private func configNavBar() {
        let lable = UILabel()
        lable.text = "Currency pair"
        lable.font = .boldSystemFont(ofSize: 22)
        lable.textColor = .white
        navigationItem.titleView = lable
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoosePairCell.reuseId, for: indexPath) as? ChoosePairCell else { return UICollectionViewCell() }
        
        let pair = presenter.pair[indexPath.row]
        cell.configure(pair: pair.name)
        
        if presenter.isSelectedPair != nil, pair.name == presenter.isSelectedPair?.name {
            cell.backgroundColor = .brandGreen
        } else if presenter.isSelectedPair == nil, indexPath.row == 0 {
            cell.backgroundColor = .brandGreen
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectPair(pair: presenter.pair[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 14,
                      height: 54)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
    }
}
