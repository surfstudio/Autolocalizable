//
//  CustomLocalizableValueService.swift
//  Autolocalizable
//
//  Created by Virpik on 17/04/2019.
//

import Foundation

public final class CustomLocalizableValueService: LocalizableValueService {

    // MARK: - Private properties

    private var dictionary: [String: String]
    private var defaultValue: String

    // MARK: - Initializing

    public init(with dictionary: [Locale: String], defaultValue: String) {
        self.dictionary = dictionary.reduce(into: [String: String](), { (dict, oldItem) in
            dict[oldItem.key.resourcesFileName] = oldItem.value
        })
        self.defaultValue = defaultValue
    }

    // MARK: - LocalizableValueService

    public func localized(_ table: String, _ key: String, _ args: [CVarArg], locale: Locale) -> String {
        let format = dictionary[locale.resourcesFileName] ?? defaultValue
        return String(format: format, locale: locale, arguments: args)
    }

}
