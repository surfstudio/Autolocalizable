//
//  UITabBarItem+AutoLocalizableField.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 21/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

/// Activate AutoLocalizableField for UITabBarItem
extension UITabBarItem: AutoLocalizableField {

    public func languageWasChanged(locale: Locale, localizableString: LocalizableStringItem?) {
        title = localizableString?.value
    }

}
