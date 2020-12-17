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
    public func localized(_ table: String, _ key: String, _ args: [CVarArg], locale: Locale, _ bundle: Bundle) -> String {
        let rightBundle =  BaseLocalizableValueService.identifyBundle(bundle, byLocale: locale)
        let format = NSLocalizedString(key, tableName: table, bundle: rightBundle, comment: "")
        return String(format: format, locale: locale, arguments: args)
    }

    // MARK: - Helpers

    private static func identifyBundle(_ bundle: Bundle, byLocale locale: Locale) -> Bundle {
        if let cachedBundle = bundles[locale] {
            return cachedBundle
        }
        let path = bundle.path(forResource: locale.resourcesFileName, ofType: "lproj") ?? ""
        let concreteBundle = Bundle(path: path) ?? bundle
        bundles[locale] = concreteBundle
        return concreteBundle
    }

}

