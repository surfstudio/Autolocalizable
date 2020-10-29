//
//  LanguagesViewController.swift
//  Autolocalizable
//
//  Created by git on 04/10/2019.
//  Copyright (c) 2019 git. All rights reserved.
//

import UIKit
import Autolocalizable

final class LanguagesViewController: UIViewController {

    let availableLangs = ["en_US", "ru_RU", "fr_FR", "de_DE"].map {
        Locale(identifier: $0)
    }

    // MARK: Subviews

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Autolocalizable ViewController.title
        localizedTitle = Localizable.LanguagesViewController_Title
/**
        tabBarItem = UITabBarItem(
            title: Localizable.LanguagesViewController_Title.value,
            image: UIImage(named: "ic_star_grey"),
            selectedImage: nil
        )
**/
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

}

extension LanguagesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locale = availableLangs[indexPath.row]
        LocaleManager.shared.setAs(current: locale)

        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}

extension LanguagesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableLangs.count
    }

    // FIXME: -
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let locale = availableLangs[indexPath.row]
        cell.textLabel?.localized = LocalizableStringItem(locale.identifier, bundle: Bundle.main)
        cell.selectionStyle = .none
        return cell
    }
}

final class LanguageCell: UITableViewCell {

}
