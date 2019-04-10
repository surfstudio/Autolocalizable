//
//  AutoLocalizableAttributedField.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 13/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// To simplify auto-localization, single-field elements
public protocol AutoLocalizableAttributedField: AutoLocalizableFields {

    var localizedAttributed: LocalizableAttributedStringItem? { get set }

    func languageWasChanged(locale: Locale, localizableAttributedString: LocalizableAttributedStringItem?)

}

public extension AutoLocalizableAttributedField {

    private var localizedAttributedKey: String {
        return "localizedAttributedKey"
    }

    public var localizedAttributed: LocalizableAttributedStringItem? {
        get {
            return getItem(key: localizedAttributedKey)
        }

        set (value) {
            registration(item: value)
        }
    }

    // MARK: - Helper

    private func registration(item: LocalizableAttributedStringItem?) {
        guard let item = item else {
            remove(forKey: localizedAttributedKey)
            return
        }

        registration(item: item) { [weak self] in
            self?.languageWasChanged(locale: $0, localizableAttributedString: $1)
        }
    }

}
