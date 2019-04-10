//
//  ViewController.swift
//
//  Created by Anatoly Cherkasov on 20/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

// Base protocol
public protocol Autolocalizable: class {

    func languageWasChanged(locale: Locale)

}
