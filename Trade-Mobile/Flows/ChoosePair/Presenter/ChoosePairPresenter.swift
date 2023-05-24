//
//  CoosePairPresenter.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 15.05.2023.
//

import Foundation

protocol ChoosePairViewProtocol: AnyObject {
    func reloadData()
}

protocol ChoosePairPresenterProtocol {
    init(view: ChoosePairViewProtocol, router: RouterProtocol)
    var pair: [Pair] { get set }
    func viewDidLoad()
    func didSelectPair(pair: Pair)
}

class ChoosePairPresenter: ChoosePairPresenterProtocol {

    var pair: [Pair] = []
    weak var view: ChoosePairViewProtocol?
    var router: RouterProtocol?
    
    //MARK: - Init
    required init(view: ChoosePairViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }

    //MARK: - Functions
    func viewDidLoad() {
        pair = getPair()
        view?.reloadData()
    }
    
    func didSelectPair(pair: Pair) {
        print(pair)
    }
    
    private func getPair() -> [Pair] {
        let baseUrl = "https://www.tradingview.com/chart"
        let pair = [
        Pair(name: "EUR/USD", pairChartUrl: baseUrl),
        Pair(name: "GPB/USD", pairChartUrl: baseUrl),
        Pair(name: "USD/JPY", pairChartUrl: baseUrl),
        Pair(name: "AUD/USD", pairChartUrl: baseUrl),
        Pair(name: "NZD/USD", pairChartUrl: baseUrl),
        Pair(name: "USD/SGD", pairChartUrl: baseUrl),
        Pair(name: "BRL/USD", pairChartUrl: baseUrl),
        Pair(name: "USD/CHF", pairChartUrl: baseUrl),
        Pair(name: "USD/MXN", pairChartUrl: baseUrl),
        Pair(name: "USD/GMD", pairChartUrl: baseUrl)
        ]
        return pair
    }
}
