//
//  AutoLocalizableField.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 21/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// To simplify auto-localization, single-field elements
public protocol AutoLocalizableField: AutoLocalizableFields {

    var localized: LocalizableStringItem? { get set }

    func languageWasChanged(locale: LocaleType, localizableString: LocalizableStringItem?)
}

public extension AutoLocalizableField {

    private var localizedKey: String {
        return "localized"
    }

    public var localized: LocalizableStringItem? {
        get {
            return getItem(key: localizedKey)
        }

        set (value) {
            registration(item: value)
        }
    }

    // MARK: - Helper

    private func registration(item: LocalizableStringItem?) {
        guard let item = item else {
            remove(forKey: localizedKey)
            return
        }

        registration(item: item) { [weak self] in
            self?.languageWasChanged(locale: $0, localizableString: $1)
        }
    }

}
