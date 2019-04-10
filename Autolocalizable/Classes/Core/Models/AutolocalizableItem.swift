//
//  LocalizableItem.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 26/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

final public class AutolocalizableItem<Item>: Autolocalizable, Keyable {

    // MARK: - Nested types

    public typealias LocalizableItemHandler = ((_ locale: LocaleType, _ item: Item) -> Void)

    // MARK: - Properties

    public var key: String?
    public var item: Item
    public var action: LocalizableItemHandler

    // MARK: - Initializing

    public init (key: String? = nil, item: Item, action: @escaping LocalizableItemHandler) {
        self.key = key
        self.item = item
        self.action = action
    }

    // MARK: - AutoLocalizable

    public func languageWasChanged(locale: LocaleType) {
        action(locale, item)
    }

}
