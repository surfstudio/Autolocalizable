//
//  AnyObject.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 20/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIViewController: AutoLocalizableFields {

    private var localizedTitleKey: String {
        return "localizedTitle"
    }

    private var updateUIKey: String {
        return "updateUIKey"
    }

    /// Autolocalization UIViewController.title
    public var localizedTitle: LocalizableStringItem? {
        get {
            return getItem(key: localizedTitleKey)
        }

        set(value) {
            guard let value = value else {
                remove(forKey: localizedTitleKey)
                return
            }
            registration(key: localizedTitleKey, item: value) { [weak self] in
                self?.title = $1.value
            }
        }
    }

    /// Supporting blocks autolocalization following
    public func autoLocalizable(handler: @escaping ((Locale) -> Void)) {
        let item = AutolocalizableItem(item: Void()) { locale, _ in
            handler(locale)
        }
        LocaleManager.shared.registrator.registration(for: self, item: item)
    }

}
