//
//  Locale.swift
//
//  Created by Anatoly Cherkasov on 20/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public extension Locale {

    var resourcesFileName: String {
        return self.identifier.split(separator: "_").first?.lowercased() ?? ""
    }

}
