//
//  Autolocalizable.swift
//  Autolocalizable
//
//  Created by Anatoly Cherkasov on 17/02/2019.
//  Copyright © 2019 Anatoly Cherkasov. All rights reserved.
//

import Foundation

/// Returns the object to be stored in memory at the desired time
public func autoLocalizable(anchor: AnyObject, handler: @escaping ((LocaleType) -> Void)) {
    let item = AutolocalizableItem(item: Void()) { locale, _ in
        handler(locale)
    }
    LocaleManager.shared.registrator.registration(for: anchor, item: item)
}

final public  class LocaleManager: AutolocalizationObjectsStoreDelegate {

    // MARK: - Constants

    private enum Constants {
        static let userDefaultKey = "LocaleManager.currentLocale"
    }

    // MARK: - Properties

    static let shared: LocaleManager = LocaleManager()

    // MARK: - Readonly properties

    var finder: AutolocalizationObjectsFinder {
        return store
    }

    var registrator: AutolocalizationObjectsRegistrator {
        return store
    }

    public private(set) var availableLocales: [LocaleType] = [.en, .ru]
    public private(set) var currentLocale: Locale = Locale.current

    // MARK: - Private properties

    private lazy var store = AutolocalizationObjectsStore()

    private init() {
        store.delegate = self
        restoreCurrentLocale()
    }

    /// Setup current locale
    public func setAs(current locale: LocaleType) {
        saveCurrentLocale(locale: locale)
        currentLocale = locale.locale

        store.items.forEach { element in
            DispatchQueue.main.async {
                element.languageWasChanged(locale: locale)
            }
        }
    }

    // MARK: - AutolocalizationObjectsStoreDelegate

    public func newRegistered(item: Autolocalizable) {
        item.languageWasChanged(locale: currentLocale.localeType)
    }

    // MARK: - Private helpers

    private func saveCurrentLocale(locale: LocaleType) {
        UserDefaults.standard.set(locale.rawValue, forKey: Constants.userDefaultKey)
    }

    private func restoreCurrentLocale() {
        let rawValue = UserDefaults.standard.string(forKey: Constants.userDefaultKey) ?? ""
        setAs(current: LocaleType(raw: rawValue))
    }

}
