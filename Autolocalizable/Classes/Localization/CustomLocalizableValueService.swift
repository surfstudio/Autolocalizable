//
//  CustomLocalizableValueService.swift
//  Autolocalizable
//
//  Created by Virpik on 17/04/2019.
//

import Foundation

public final class CustomLocalizableValueService: LocalizableValueService {

    // MARK: - Private properties

    private var dictionary: [Locale: String]

    // MARK: - Initializing

    public init(with dictionary: [Locale: String]) {
        self.dictionary = dictionary
    }

    // MARK: - LocalizableValueService

    public func localized(_ table: String, _ key: String, _ args: [CVarArg], locale: Locale) -> String {
        let format = dictionary[locale] ?? dictionary.first?.value ?? ""
        return String(format: format, locale: locale, arguments: args)
    }

}
