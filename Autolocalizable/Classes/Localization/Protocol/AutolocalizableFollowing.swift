//
//  AutolocalizableFollowing.swift
//
//  Created by Anatoly Cherkasov on 13/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// Allows you to bind the class to the autolocalization system
/// The class must implement the method `func languageWasChanged(locale: Locale)`
public protocol AutolocalizableFollowing: Autolocalizable, AutoLocalizableFields {

}

public extension AutolocalizableFollowing {

    private var autolocalizableFollowingKey: String {
        return "autolocalizableFollowingKey"
    }

    func followAutolocalization() {
        registration(item: Void()) { [weak self] locale, _ in
            self?.languageWasChanged(locale: locale)
        }
    }

    func unfollowAutolocalization() {
        remove(forKey: autolocalizableFollowingKey)
    }
}
