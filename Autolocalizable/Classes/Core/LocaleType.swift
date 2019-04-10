//
//  LocaleType.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 20/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public enum LocaleType: String {

    case en
    case ru

    init(raw: String) {
        self = LocaleType(rawValue: raw) ?? .default
    }

}

public extension LocaleType {

    static var `default`: LocaleType {
        return .ru
    }

    var locale: Locale {
        return Locale(identifier: self.rawValue)
    }

}
