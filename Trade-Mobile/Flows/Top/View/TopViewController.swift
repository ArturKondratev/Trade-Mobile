//
//  TopViewController.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 13.05.2023.
//

import UIKit

class TopViewController: UIViewController  {
    
    var topTraders = [Trader]()
    var myTimer: Timer?
    
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
        topView.tableView.delegate = self
        topView.tableView.dataSource = self
        configNavBar()
        startUpdateTOP()
        topTraders = makeMocTraiders()
    }
    //MARK: - Configure
    private func configNavBar() {
        let lable = UILabel()
        lable.text = "TOP 10 Traders"
        lable.font = .boldSystemFont(ofSize: 22)
        lable.textColor = .white
        navigationItem.titleView = lable
    }
    
    func makeMocTraiders() -> [Trader] {
        return [
            Trader(country: "spain", name: "Oliver", deposit: 2367, profit: 336755),
            Trader(country: "canada", name: "Jack", deposit: 1175, profit: 148389),
            Trader(country: "germany", name: "James", deposit: 1000, profit: 13500),
            Trader(country: "spain", name: "William", deposit: 9104, profit: 12300),
            Trader(country: "brazil", name: "Oscar", deposit: 8289, profit: 10432),
            Trader(country: "south-korea", name: "George", deposit: 7675, profit: 9345),
            Trader(country: "germany", name: "Thomas", deposit: 6987, profit: 8686),
            Trader(country: "new-zealand", name: "Jacob", deposit: 5333, profit: 7503),
            Trader(country: "usa", name: "Harry", deposit: 4301, profit: 6433),
            Trader(country: "spain", name: "Jack", deposit: 3211, profit: 5432),
        ]
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topTraders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Top10ViewCell.identifier, for: indexPath) as? Top10ViewCell else { return UITableViewCell() }
        cell.configure(trader: topTraders[indexPath.row])
        cell.number.text = String("\(indexPath.row + 1)")
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .clear
        } else {
            cell.backgroundColor = .brandGrey
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
    
    //MARK: - Functions
    func startUpdateTOP() {
        myTimer = Timer.scheduledTimer(timeInterval: 1,
                                       target: self,
                                       selector: #selector(updateTraider),
                                       userInfo: nil,
                                       repeats: true)
    }
    
    @objc func updateTraider() {
        let coin = Int.random(in: 0...100)
        let actionState = Bool.random()
        let randomInt = Int.random(in: 0..<topTraders.count - 1)
        var traider = topTraders.remove(at: randomInt)
        if actionState {
            traider.deposit += coin
            traider.profit += coin
        } else {
            traider.deposit -= coin
            traider.profit -= coin
        }
        topTraders.insert(traider, at: randomInt)
        DispatchQueue.main.async {
            self.topView.tableView.reloadData()
        }
    }
}
