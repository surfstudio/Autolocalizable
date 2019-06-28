//
//  File.swift
//
//  Created by Anatoly Cherkasov on 13/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public struct LocalizableAttributedStringItem {

    // MARK: - Properties

    public var value: NSAttributedString {
        return getValue()
    }

    public private(set) var item: LocalizableStringItem

    private var attributed: [NSAttributedString.Key: Any]

    // MARK: - Private properties

    private var transforms: [((NSAttributedString) -> NSAttributedString)] = []

    public init(item: LocalizableStringItem, attributed: [NSAttributedString.Key: Any]) {
        self.item = item
        self.attributed = attributed
    }
    
    // MARK: - Transforms

    public func add(transform: @escaping ((NSAttributedString) -> NSAttributedString)) -> LocalizableAttributedStringItem {
        var `self` = self
        self.transforms.append(transform)
        return self
    }

    public func add(attributes: [NSAttributedString.Key: Any], to range: NSRange) -> LocalizableAttributedStringItem {
        var `self` = self
        self.transforms.append { (attributed) -> NSAttributedString in
            let mutableAttributed = NSMutableAttributedString(attributedString: attributed)
            mutableAttributed.addAttributes(attributes, range: range)
            return mutableAttributed
        }
        return self
    }

    // MARK: - Helpers

    private func getValue() -> NSAttributedString {
        let value = item.value
        return applyTransforms(string: value)
    }

    private func applyTransforms(string: String) -> NSAttributedString {
        let attributedString = NSAttributedString(string: string, attributes: attributed)
        return transforms.reduce(attributedString) { (str, transform ) -> NSAttributedString in
            return transform(str)
        }
    }

}
