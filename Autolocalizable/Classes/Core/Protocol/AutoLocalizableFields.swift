//
//  AutoLocalizableFields.swift
//
//  Created by Anatoly Cherkasov on 26/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public protocol AutoLocalizableFields: class {

}

public extension AutoLocalizableFields {

    typealias AutolocalizableHandler<Item> = AutolocalizableItem<Item>.LocalizableItemHandler

    /// Creates and adds a new field to the autolocalization system for this class.
    func registration<Item>(key: String? = nil, item: Item, handler: @escaping AutolocalizableHandler<Item>) {
        let autolocalizableItem = AutolocalizableItem(key: key, item: item, action: handler)
        registration(autolocalizableItem: autolocalizableItem)
    }

    /// Adds a new field to the autolocalization system for this class.
    /// If the key field is not nil and there is a duplicate - replace
    func registration<Item>(autolocalizableItem item: AutolocalizableItem<Item>) {
        let registrator = LocaleManager.shared.registrator
        registrator.registration(for: self, item: item)
    }

    /// Allows you to obtain a registered item
    func getItem<Item>(key: String) -> Item? {
        let finder = LocaleManager.shared.finder
        return finder.findItem(by: key, for: self)
    }

    /// Delete by key, for the current target
    func remove(forKey key: String) {
        let registrator = LocaleManager.shared.registrator
        registrator.remove(for: self, key: key)
    }

    /// Removes all fields in this target
    func removeAll() {
        let registrator = LocaleManager.shared.registrator
        registrator.removeAll(for: self)
    }

}
