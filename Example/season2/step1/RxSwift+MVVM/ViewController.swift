//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ view: UIView?, isHidden: Bool) {
        guard let view else { return }

        UIView.animate(withDuration: 0.3) { [weak view] in
            view?.isHidden = isHidden
        } completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        }
    }


    private func downloadJSON(from urlString: String, completion: ((String?) -> Void)?) {
        DispatchQueue.global().async {
            let url = URL(string: urlString)!
            let data = try! Data(contentsOf: url)
            let json = String(data: data, encoding: .utf8)

            DispatchQueue.main.async {
                completion?(json)
            }
        }
    }

    // MARK: SYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""

        /// show indicator
        setVisibleWithAnimation(activityIndicator, isHidden: false)

        downloadJSON(from: MEMBER_LIST_URL) { [weak self] json in
            self?.editView.text = json
            if let activityIndicator = self?.activityIndicator {
                /// hide indicator
                self?.setVisibleWithAnimation(activityIndicator, isHidden: true)
            }

        }
    }
}
