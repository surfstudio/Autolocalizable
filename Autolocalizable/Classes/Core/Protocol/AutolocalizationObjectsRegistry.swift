//
//  AutolocalizationObjectsRegistry.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 12/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public protocol AutolocalizationObjectsRegistry {

    var items: [Autolocalizable] { get }

}
