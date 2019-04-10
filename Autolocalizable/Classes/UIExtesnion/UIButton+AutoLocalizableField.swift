//
//  UIButton+AutoLocalizableField.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 21/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

/// Activate AutoLocalizableField for UIButton
extension UIButton: AutoLocalizableField, AutoLocalizableAttributedField {

    public func languageWasChanged(locale: Locale, localizableString: LocalizableStringItem?) {
        setTitle(localizableString?.value, for: .normal)
        superview?.setNeedsLayout()
        superview?.layoutIfNeeded()
    }

    public func languageWasChanged(locale: Locale, localizableAttributedString: LocalizableAttributedStringItem?) {
        setAttributedTitle(localizableAttributedString?.value, for: .normal)
        superview?.setNeedsLayout()
        superview?.layoutIfNeeded()
    }

}
