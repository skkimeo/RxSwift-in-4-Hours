//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by sun on 2023/06/20.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation

import RxSwift

class MenuLisViewModel {

    // MARK: - Struct

    private struct Response: Decodable {
        let menus: [MenuItem]
    }


    // MARK: - Property

    var menuObservable = BehaviorSubject<[Menu]>(value: [])
    lazy var itemCount = menuObservable.map { $0.map { $0.count }.reduce(0, +) }
    lazy var totalPrice = menuObservable.map { $0.map { $0.count * $0.price }.reduce(0, +) }


    // MARK: - Init

    init() {
        _ = APIService.fetchAllMenusRx()
            .take(1)
            .map {
                let response = try! JSONDecoder().decode(Response.self, from: $0)

                return response.menus.map { Menu(menuItem: $0) }
            }
            .bind(to: menuObservable)
    }


    // MARK: - Method

    func clearButtonDidTap() {
        _ = menuObservable
            .take(1)
            .map { $0.map { Menu(name: $0.name, price: $0.price, count: 0)} }
            .subscribe { self.menuObservable.onNext($0) }
    }

    func changeCount(of item: Menu, increase: Int) {
        _ = menuObservable
            .take(1)
            .map { $0.map { Menu(name: $0.name, price: $0.price, count: $0.count + (item == $0 ? increase : 0)) } }
            .subscribe { self.menuObservable.onNext($0) }
    }

    func onOrder() {
        
    }
}
