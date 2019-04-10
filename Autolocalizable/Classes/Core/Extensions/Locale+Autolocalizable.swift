//
//  Locale.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 20/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public extension Locale {

    var localeType: LocaleType {
        let id = self.identifier.split(separator: "_").first?.lowercased() ?? LocaleType.default.rawValue
        return LocaleType(raw: id)
    }

}
