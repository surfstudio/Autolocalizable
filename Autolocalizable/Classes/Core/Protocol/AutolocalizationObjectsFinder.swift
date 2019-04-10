//
//  AutolocalizationObjects.swift
//
//  Created by Anatoly Cherkasov on 12/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

protocol AutolocalizationObjectsFinder {

    func findItem<Item>(by key: String, for target: AnyObject?) -> Item?

}
