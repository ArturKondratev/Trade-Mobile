//
//  TopViewController.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 13.05.2023.
//

import UIKit

class TopViewController: UIViewController  {
    
    var presenter: TopPresenterProtocol!
    private var topView: TopView {
        return self.view as! TopView
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = TopView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        topView.tableView.delegate = self
        topView.tableView.dataSource = self
        presenter.viewDidLoad()
    }
    
    //MARK: - ConfigureNavBar
    private func configNavBar() {
        let lable = UILabel()
        lable.text = "TOP 10 Traders"
        lable.font = .boldSystemFont(ofSize: 22)
        lable.textColor = .white
        navigationItem.titleView = lable
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.topTraders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Top10ViewCell.identifier, for: indexPath) as? Top10ViewCell else { return UITableViewCell() }
        cell.configure(trader: presenter.topTraders[indexPath.row])
        cell.number.text = String("\(indexPath.row + 1)")
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .clear
        } else {
            cell.backgroundColor = .brandGrey
        }
        if indexPath.row == presenter.topTraders.count - 1 {
            cell.cofigureContentView()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Top10Header.identifier) as? Top10Header else { return UITableViewHeaderFooterView() }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

//MARK: - TopViewProtocol
extension TopViewController: TopViewProtocol {
    func reloadData() {
        topView.tableView.reloadData()
    }
}
