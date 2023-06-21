//
//  Menu.swift
//  RxSwift+MVVM
//
//  Created by sun on 2023/06/20.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation

// viewModel(i.e. View를 위한 Model)
struct Menu: Equatable {
    let id = UUID()
    var name: String
    var price: Int
    var count: Int

    init(name: String, price: Int, count: Int = 0) {
        self.name = name
        self.price = price
        self.count = count
    }
}

extension Menu {

    init(menuItem: MenuItem) {
        self.init(name: menuItem.name, price: menuItem.price)
    }
}
