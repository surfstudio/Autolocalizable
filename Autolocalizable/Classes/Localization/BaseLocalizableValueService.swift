//
//  LocalizableValueServie.swift
//
//  Created by Anatoly Cherkasov on 13/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// String localization helpers
final public class BaseLocalizableValueService: LocalizableValueService {

    /// In-memory caching
    private static var bundles: [Locale: Bundle] = [:]

    /// Getting a localized string
    public func localized(_ table: String, _ key: String, _ args: [CVarArg], locale: Locale, _ bundle: Bundle = Bundle.main) -> String {
        var rightBundle = bundle
        if bundle == Bundle.main {
            rightBundle = BaseLocalizableValueService.getBundle(byLocale: locale)
        }

        let format = NSLocalizedString(key, tableName: table, bundle: rightBundle, comment: "")
        return String(format: format, locale: locale, arguments: args)
    }

    // MARK: - Helpers

    private static func getBundle(byLocale locale: Locale) -> Bundle {
        if let bundle = bundles[locale] {
            return bundle
        }
        let path = Bundle.main.path(forResource: locale.resourcesFileName, ofType: "lproj") ?? ""
        let bundle = Bundle(path: path) ?? Bundle.main
        bundles[locale] = bundle
        return bundle
    }

}
