//
//  Defaults.swift
//  LGSegmentedControl
//
//  Created by Linus Geffarth on 05.12.18.
//

import UIKit

internal var _segmentsCornerRadius: CGFloat = 6

internal var _animateStateChange: Bool = true

internal var _selectedColor: (background: UIColor, text: UIColor) = (#colorLiteral(red: 0.2196078431, green: 0.6235294118, blue: 0.9764705882, alpha: 1), .white)

internal var _deselectedColor: (background: UIColor, text: UIColor) = (.clear, .black)

internal var _font: UIFont = UIFont.systemFont(ofSize: 15)
