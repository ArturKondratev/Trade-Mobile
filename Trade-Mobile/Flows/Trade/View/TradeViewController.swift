//
//  TradeViewController.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 13.05.2023.
//

import UIKit
import WebKit

class TradeViewController: UIViewController, WKNavigationDelegate {
    
    var presenter: TradeViewPresenterProtocol!
    private var tradeView: TradeView {
        return self.view as! TradeView
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = TradeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        tradeView.webView.navigationDelegate = self
        tradeView.delegate = self
        tradeView.investmentView.delegate = self
        tradeView.timerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    //MARK: - Configure
    private func configNavBar() {
        let lable = UILabel()
        lable.text = "Trade"
        lable.font = .boldSystemFont(ofSize: 22)
        lable.textColor = .white
        navigationItem.titleView = lable
    }
}

//MARK: - TradeViewProtocol
extension TradeViewController: TradeViewProtocol {
    
    func loadChart(pair: Pair) {
        if let url = URL(string: pair.pairChartUrl) {
            let request = URLRequest(url: url)
            tradeView.webView.load(request)
        }
        
        let attributedText = NSMutableAttributedString(string: pair.name, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: 1
        ])
        self.tradeView.pairButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    func updateInvestment(investCount: Double, balance: Double) {
        let balanceString = String(format: "%.03f", balance)
        let investString = String(format: "%.03f", investCount)
        tradeView.depositLable.text = balanceString
        tradeView.investmentView.currencyLable.text = investString
    }
}

//MARK: - TradeViewActionProtocol
extension TradeViewController: TradeViewActionProtocol, InvestmentViewProtocol, TimerViewProtocol {
    
    func didTabPairButton() {
        guard let navVC = self.navigationController else { return }
        presenter.didTabPairButton(navVC: navVC)
    }
    
    func investmentPlusButtonAction() {
        presenter.didTabInvestmentPlusButton()
    }
    
    func investmentMinusButtonAction() {
        presenter.didTabInvestmentMinusButton()
    }
    
    func timerPlusButtonAction() { }
    
    func timerMinusButtonAction() { }
    
    func didTabSellBuyButton() {
        presenter.startTraiding()
    }
}
