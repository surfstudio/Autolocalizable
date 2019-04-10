//
//  AutolocalizationObjectsRegistrator.swift
//
//  Created by Anatoly Cherkasov on 12/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public protocol AutolocalizationObjectsRegistrator {

    /// Registration based on the type and key, if the object was find - replacing,
    /// if the key was find - replacing
    func registration<Item>(for target: AnyObject, item: AutolocalizableItem<Item>)

    /// Simple registration, if the object was previously met - replacing.
    func registration(for target: AnyObject, item: Autolocalizable)

    func remove(for target: AnyObject, key: String)

    func removeAll(for target: AnyObject)

}
