//
//  TradeViewController.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 13.05.2023.
//

import UIKit
import WebKit

class TradeViewController: UIViewController {

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
        
        loadChart()
    }

    //MARK: - Configure
    private func configNavBar() {
        let lable = UILabel()
        lable.text = "Trade"
        lable.font = .boldSystemFont(ofSize: 22)
        lable.textColor = .white
        navigationItem.titleView = lable
    }
    
    func loadChart() {
        if let url = URL(string: "https://www.tradingview.com/chart") {
            let request = URLRequest(url: url)
                tradeView.webView.load(request)
        }
    }
}

extension TradeViewController: WKNavigationDelegate {
    
    
}

extension TradeViewController: TradeViewProtocol {
    func pairButtonAction() {
        let vc = ChoosePairViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
