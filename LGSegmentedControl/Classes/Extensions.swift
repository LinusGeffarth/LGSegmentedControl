//
//  Extensions.swift
//  LGSegmentedControl
//
//  Created by Linus Geffarth on 26.11.18.
//

import UIKit

extension Collection where Indices.Iterator.Element == Index {
    /// Returns the element at the specified index if it is within bounds, otherwise nil
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIStackView {
    func add(arrangedSubviews: [UIView]) {
        for view in arrangedSubviews {
            self.addArrangedSubview(view)
        }
    }
}

extension UIStackView.Distribution {
    init?(_ string: String?) {
        guard let string = string else { return nil }
        switch string.lowercased() {
        case "fill":
            self = .fill
        case "fillEqually".lowercased():
            self = .fillEqually
        case "fillProportionally".lowercased():
            self = .fillProportionally
        case "equalSpacing".lowercased():
            self = .equalSpacing
        case "equalCentering".lowercased():
            self = .equalCentering
        default:
            return nil
        }
    }
    
    var string: String {
        switch self {
        case .fill:
            return "fill"
        case .fillEqually:
            return "fillEqually"
        case .fillProportionally:
            return "fillProportionally"
        case .equalSpacing:
            return "equalSpacing"
        case .equalCentering:
            return "equalCentering"
        }
    }
}

infix operator ???: NilCoalescingPrecedence

public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
    case let value?: return String(describing: value)
    case nil: return defaultValue()
    }
}
