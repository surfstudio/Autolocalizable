//
//  StringDecline.swift
//
//  Created by Anatoly Cherkasov on 13/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// Must be duplicated in .string file declined phrase:
/// "keyValue#one" = "value for 1, 21, 31, ...";
/// "keyValue#many" = "value for 2, 3, 22, ...";
/// "keyValue#other" = "value for 5, 6, 7, 25, ...";

/// Types of quantitative declensions
public enum StringDecline: String {
    case one /// For values ending with '1' except 11
    case many /// For values from 5 to 20 and numbers ending in '0' or greater than five
    case other /// For other values
}

extension StringDecline {

    /// Key string value
    public var key: String {
        switch self {
        case .one: return "#one"
        case .many: return "#many"
        case .other: return "#other"
        }
    }

    init(count: Int) {
        self = StringDecline.declension(count)
    }

    /// Returns the value type by number
    private static func declension(_ count: Int) -> StringDecline {

        if (count % 10 == 1) && (count != 11) {
            return .one
        }

        if (count >= 5) && (count <= 20) {
            return .many
        }

        if (count % 10 >= 5) || (count % 10 == 0) {
            return .many
        }

        if (count % 10 >= 2) && (count % 10 <= 4) {
            return .other
        }

        return .other
    }

}
