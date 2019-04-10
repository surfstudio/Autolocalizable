//
//  AutolocalizationObjectsStore.swift
//
//  Created by Anatoly Cherkasov on 26/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public protocol AutolocalizationObjectsStoreDelegate: class {

    func newRegistered(item: Autolocalizable)

}

final class AutolocalizationObjectsStore: AutolocalizationObjectsFinder,
    AutolocalizationObjectsRegistrator, AutolocalizationObjectsRegistry {

    // MARK: - AutolocalizationObjectsRegistry property

    var items: [Autolocalizable] {
        garbageCollection()
        return objects.reduce([]) {
            return $0 + $1.items
        }
    }

    // MARK: - Properties

    weak var delegate: AutolocalizationObjectsStoreDelegate?

    // MARK: - Private property

    private var objects: [WeatAutoLocalizableStore] = []

    // MARK: - AutolocalizationObjectsFinder

    func findItem<Item>(by key: String, for target: AnyObject?) -> Item? {
        garbageCollection()

        guard let store = getWeakStore(for: target) else {
            return nil
        }

        for element in store.items {
            if let element = element as? AutolocalizableItem<Item>, element.key == key {
                return element.item
            }
        }

        return nil
    }

    // MARK: - AutolocalizationObjectsRegistrator

    func registration(for target: AnyObject, item: Autolocalizable) {
        garbageCollection()

        guard let store = getWeakStore(for: target) else {
            let store = WeatAutoLocalizableStore(target: target, item: item)
            objects.append(store)
            delegate?.newRegistered(item: item)
            return
        }

        let foundIndex = store.items.index {
            $0 === item
        }

        guard let index = foundIndex else {
            store.items.append(item)
            delegate?.newRegistered(item: item)
            return
        }

        store.items[index] = item
        delegate?.newRegistered(item: item)
    }

    func registration<Item>(for target: AnyObject, item: AutolocalizableItem<Item>) {
        garbageCollection()

        guard let store = getWeakStore(for: target) else {
            let store = WeatAutoLocalizableStore(target: target, item: item)
            objects.append(store)
            delegate?.newRegistered(item: item)
            return
        }

        guard let key = item.key else {
            store.items.append(item)
            delegate?.newRegistered(item: item)
            return
        }

        let foundIndex = store.items.enumerated().first {
            guard let foundItem = $0.element as? AutolocalizableItem<Item> else {
                return false
            }
            return foundItem.key == key
        }?.offset

        guard let index = foundIndex else {
            store.items.append(item)
            delegate?.newRegistered(item: item)
            return
        }

        store.items[index] = item
        delegate?.newRegistered(item: item)
    }

    func remove(for target: AnyObject, key: String) {
        guard let store = getWeakStore(for: target) else {
            return
        }

        store.items.removeAll {
            guard let foundKey = ($0 as? Keyable)?.key else {
                return false
            }
            return foundKey == key
        }
    }

    func removeAll(for target: AnyObject) {
        objects.removeAll {
            $0.target === target
        }
    }

    // MARK: - Private logic

    private func getWeakStore(for target: AnyObject?) -> WeatAutoLocalizableStore? {
        return objects.last {
            $0.target === target
        }
    }

    private func garbageCollection() {
        objects = objects.filter {
            $0.target != nil
        }
    }

}
