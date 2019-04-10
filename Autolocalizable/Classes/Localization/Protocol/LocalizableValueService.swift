//
//  LocalizableValueService.swift
//  Autolocalizable
//
//  Created by Virpik on 11/04/2019.
//

import Foundation

/// The Protocol of the service to receive a transfer key
public protocol LocalizableValueService {

    /// Method should return a localized string
    /// - Parameter table: Table name .strings file (default: `Localizable`)
    /// - Parameter key: Key of the string to be localized
    /// - Parameter args: List of options for formatting a string
    /// - Parameter locale: The locale of the language for which you want to localize
    /// - Returns: Localized string
    func localized(_ table: String, _ key: String, _ args: [CVarArg], locale: Locale) -> String

}
