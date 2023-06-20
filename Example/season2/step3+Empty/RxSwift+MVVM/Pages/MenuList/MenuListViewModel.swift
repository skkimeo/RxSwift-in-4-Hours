//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by sun on 2023/06/20.
//  Copyright © 2023 iamchiwon. All rights reserved.
//

import Foundation

class MenuLisViewModel {

    var menus: [Menu] = [
        Menu(name: "튀김1", price: 100, count: 0),
        Menu(name: "튀김2", price: 100, count: 0),
        Menu(name: "튀김3", price: 100, count: 0),
        Menu(name: "튀김4", price: 100, count: 0)
    ]

    var itemCount = 5
    var totalPrice = 10_000
}
