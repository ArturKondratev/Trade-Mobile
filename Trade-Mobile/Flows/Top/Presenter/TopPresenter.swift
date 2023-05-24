//
//  TopPresenter.swift
//  Trade-Mobile
//
//  Created by Артур Кондратьев on 14.05.2023.
//

import Foundation

protocol TopViewProtocol: AnyObject {
    func reloadData()
}

protocol TopPresenterProtocol {
    init(view: TopViewProtocol, router: RouterProtocol)
    var topTraders: [Trader] { get set }
    func viewDidLoad()
}

class TopPresenter: TopPresenterProtocol {
    
    weak var view: TopViewProtocol?
    var router: RouterProtocol?
    var topTraders = [Trader]()
    private var myTimer: Timer?
    
    //MARK: - Init
    required init(view: TopViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Functions
    func viewDidLoad() {
        self.topTraders = makeMocTraiders()
        startUpdateTOP()
    }
    
    private func startUpdateTOP() {
        myTimer = Timer.scheduledTimer(timeInterval: 60 * 3,
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
        view?.reloadData()
    }
    
    private func makeMocTraiders() -> [Trader] {
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
