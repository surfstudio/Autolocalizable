//
//  LocalizableValueServie.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 13/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// String localization helpers
final public class BaseLocalizableValueService: LocalizableValueService {

    /// In-memory caching
    private static var defaultBundle: Bundle = Bundle.main
    private static var bundles: [LocaleType: Bundle] = [:]

    /// Getting a localized string
    public func localized(_ table: String, _ key: String, _ args: [CVarArg], locale: LocaleType) -> String {
        let bundle = BaseLocalizableValueService.getBundle(byLocale: locale)
        let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }

    // MARK: - Helpers

    private static func getBundle(byLocale locale: LocaleType) -> Bundle {
        if let bundle = bundles[locale] {
            return bundle
        }
        let path = Bundle.main.path(forResource: locale.rawValue, ofType: "lproj") ?? ""
        let bundle = Bundle(path: path) ?? Bundle.main
        bundles[locale] = bundle
        return bundle
    }

}
