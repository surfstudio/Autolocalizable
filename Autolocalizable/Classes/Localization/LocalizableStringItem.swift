//
//  LocalizableStringItem.swift
//
//  Created by Anatoly Cherkasov on 21/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public struct LocalizableStringItem {

    private enum Constants {
        static let table = "Localizable"
    }

    // MARK: - Properties

    public var value: String {
        return getValue()
    }

    // MARK: - Private properties

    private let table: String
    private let key: String
    private let args: [CVarArg]

    private var transforms: [((String) -> String)] = []
    private var declensionValue: Int?
    private var service: LocalizableValueService = BaseLocalizableValueService()

    // MARK: - Initializing

    public init(_ key: String = "", _ args: CVarArg...) {
        self.table = Constants.table
        self.key = key
        self.args = args
    }

    public init(_ table: String, _ key: String, _ args: CVarArg...) {
        self.table = table
        self.key = key
        self.args = args
    }

    public func set(localizableService: LocalizableValueService) -> LocalizableStringItem {
        var `self` = self
        self.service = localizableService
        return self
    }

    // MARK: - Transforms

    public func add(transform: @escaping ((String) -> String)) -> LocalizableStringItem {
        var `self` = self
        self.transforms.append(transform)
        return self
    }

    public func addDeclension(_ value: Int?) -> LocalizableStringItem {
        var `self` = self
        self.declensionValue = value
        return self
    }

    public func uppercased() -> LocalizableStringItem {
        return self.add {
            return $0.uppercased()
        }
    }

    public func lowercased() -> LocalizableStringItem {
        return self.add {
            return $0.lowercased()
        }
    }

    public func capitalizingFirstLetter() -> LocalizableStringItem {
        return self.add {
            let first = String($0.prefix(1)).capitalized
            let other = String($0.dropFirst())
            return first + other
        }
    }

    // MARK: - Attrbuted strings

    public func attributedItem(with attributed: [NSAttributedString.Key: Any]) -> LocalizableAttributedStringItem {
        return LocalizableAttributedStringItem(item: self, attributed: attributed)
    }

    // MARK: - Helpers

    private func getValue() -> String {
        // FIXME: - Remove dependency
        let locale = LocaleManager.shared.currentLocale

        if let decIntValue = declensionValue {
            let declensionType = StringDecline(count: decIntValue)
            let newKey = key + declensionType.key

            let value = service.localized(table, newKey, args, locale: locale)

            if value != newKey {
                return applyTransforms(string: value)
            }
        }

        let value = service.localized(table, key, args, locale: locale)
        return applyTransforms(string: value)
    }

    private func applyTransforms(string: String) -> String {
        return transforms.reduce(string) { (str, transform ) -> String in
            return transform(str)
        }
    }

}

/// CustomLocalizableValueService supporting
public extension LocalizableStringItem {

    init(args: [CVarArg] = [], localizationsDictionary: [Locale: String]) {
        self.init("", args)
        self = set(localizableService: CustomLocalizableValueService(with: localizationsDictionary))
    }

}
