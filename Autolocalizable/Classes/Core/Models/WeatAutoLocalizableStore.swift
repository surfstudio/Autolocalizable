//
//  WeatAutoLocalizableObject.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 12/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

final public class WeatAutoLocalizableStore {

    // MARK: - Properties

    public private(set) weak var target: AnyObject?
    public var items: [Autolocalizable]

    // MARK: - Initializing

    public init(target: AnyObject, items: [Autolocalizable]) {
        self.target = target
        self.items = items
    }

    public init(target: AnyObject, item: Autolocalizable) {
        self.target = target
        self.items = [item]
    }

}
