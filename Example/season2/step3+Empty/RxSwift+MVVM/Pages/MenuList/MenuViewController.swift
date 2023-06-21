//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class MenuViewController: UIViewController {

    private let viewModel = MenuLisViewModel()
    private var disposeBag = DisposeBag()
    private let cellID = "MenuItemTableViewCell"

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        subscribe()
    }

    private func subscribe() {
        viewModel.menuObservable
            .bind(to: tableView.rx.items(
                cellIdentifier: cellID,
                cellType: MenuItemTableViewCell.self)
            ) { index, menu, cell in
                cell.title.text = menu.name
                cell.price.text = "\(menu.price)"
                cell.count.text = "\(menu.count)"
                cell.onChange = { [weak self] in self?.viewModel.changeCount(of: menu, increase: $0) }
                
            }
            .disposed(by: disposeBag)

        viewModel.itemCount
            .map { "\($0)" }
            .observeOn(MainScheduler.instance)
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.totalPrice
            .map { $0.currencyKR() }
            .observeOn(MainScheduler.instance)
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
            let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
        viewModel.clearButtonDidTap()
    }

    @IBAction func onOrder(_ sender: UIButton) {
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
//        performSegue(withIdentifier: "OrderViewController", sender: nil)
        viewModel.onOrder()
    }
}
