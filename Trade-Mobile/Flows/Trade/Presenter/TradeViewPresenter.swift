//
//  TradeViewPresenter.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 16.05.2023.
//

import UIKit

protocol TradeViewPresenterProtocol {
    init(view: TradeViewProtocol, router: RouterProtocol)
    func viewWillAppear()
    func didTabPairButton(navVC: UINavigationController)
    func didTabInvestmentPlusButton()
    func didTabInvestmentMinusButton()
    func startTraiding()
}

protocol TradeViewProtocol: AnyObject {
    func loadChart(pair: Pair)
    func updateInvestment(investCount: Double, balance: Double)
}

class TradeViewPresenter: TradeViewPresenterProtocol {
    //MARK: - Propertis
    weak var view: TradeViewProtocol?
    var router: RouterProtocol?
    private let basePair = Pair(name: "EUR/USD", pairChartUrl: "https://www.tradingview.com/chart")
    var balance: Double = 10.000
    var investCount: Double = 1.000
    
    //MARK: - Init
    required init(view: TradeViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Functions
    func viewWillAppear() {
        view?.updateInvestment(investCount: investCount, balance: balance)
        
        guard let pair = UserDefaults.standard.data(forKey: KeyConstants.pair) else {
            view?.loadChart(pair: basePair); return
        }
        do {
            let pair = try JSONDecoder().decode(Pair.self, from: pair)
            view?.loadChart(pair: pair)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func didTabPairButton(navVC: UINavigationController) {
        router?.showChoocePairViewController(navVC: navVC)
    }
    
    func didTabInvestmentPlusButton() {
        if investCount != balance {
            investCount += 0.100
        }
        view?.updateInvestment(investCount: investCount, balance: balance)
    }
    
    func didTabInvestmentMinusButton() {
        if investCount > 0.0 {
            investCount -= 0.100
        }
        view?.updateInvestment(investCount: investCount, balance: balance)
    }
    
    func startTraiding() {
        showAlert()
    }
    
    private func showAlert() {
        let alertVC = UIAlertController(title: "Info",
                                        message: "successFully",
                                        preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel,handler: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let summ = self.investCount / 100 * 70
                if Bool.random() {
                    self.balance += summ
                } else {
                    self.balance -= summ
                }
                self.view?.updateInvestment(investCount: self.investCount, balance: self.balance)
            }
        }))
        router?.navigationController?.present(alertVC, animated: true)
    }
}
