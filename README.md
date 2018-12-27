# LGSegmentedControl

[![CI Status](https://img.shields.io/travis/linusgeffarth/LGSegmentedControl.svg?style=flat)](https://travis-ci.org/linusgeffarth/LGSegmentedControl)
[![Version](https://img.shields.io/cocoapods/v/LGSegmentedControl.svg?style=flat)](https://cocoapods.org/pods/LGSegmentedControl)
[![License](https://img.shields.io/cocoapods/l/LGSegmentedControl.svg?style=flat)](https://cocoapods.org/pods/LGSegmentedControl)
[![Platform](https://img.shields.io/cocoapods/p/LGSegmentedControl.svg?style=flat)](https://cocoapods.org/pods/LGSegmentedControl)

`LGSegmentedControl` is a highly customizable and therefor prettier version of `UISegmentedControl`.

<img src="https://github.com/LinusGeffarth/LGSegmentedControl/blob/master/screenshots/ss4.jpeg" height="400"/>

## Requirements

- written in pure Swift 4.2
- iOS 9.0 and higher

## Attribution

- not a requirement but highly appreciated: [add your app to the list of apps using this library](/Attribution.md)

## Installation

LGSegmentedControl is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LGSegmentedControl'
```

### Storyboard

Drag a view into your storyboard and set its class to `LGSegmentedControl`.  
You'll be able to customize your segmented control from there, as well as provide static segment data:

<img src="https://github.com/LinusGeffarth/LGSegmentedControl/blob/master/screenshots/ss2.png" height="300" />

And the best? It supports live rendering in interface builder!

<img src="https://github.com/LinusGeffarth/LGSegmentedControl/blob/master/screenshots/ss1.png" height="200" />

Then, create an `@IBAction` in your view controller and link to it using the `valueChanged` action.

### Programmatically

Instantiate a new view:

```swift
let control = LGSegmentedControl(frame: CGRect(x: 50, y: 50, width: 100, height: 30))
view.addSubview(control)
```

...then add the segments data:

```swift
control.segments = [
    LGSegment(title: "1 day"),
    LGSegment(title: "3 weeks"),
    LGSegment(title: "2 months"),
    LGSegment(title: "Quarter")
]
```

Lastly, define the selected segment:

```swift
control.selectedIndex = 1 // selects: "3 weeks"
```

To track user interaction, add a target and link to a method in your view controller using the `.valueChanged` action:

```swift
control.addTarget(self, action: #selector(selectedSegment(_:)), for: .valueChanged)

@objc func selectedSegment(_ segmentedControl: LGSegmentedControl) {
    // selectedSegment may be nil, if selectedIndex was set to nil (and hence none was selected)
    guard let segment = segmentedControl.selectedSegment else { return }
    let title = segment.title // ex: "3 weeks"
}
```

## Customization

You can customize many aspects of your control:

```swift
// StackView distribution, set to .fill to have each segment be as wide as required; set to .fillEqually, to have all segments be the same width
// default: .fill
public var distribution: UIStackView.Distribution

// StackView spacing
// default: 8
@IBInspectable public var spacing: CGFloat

// Background color of the whole segment
// default: .clear
@IBInspectable override public var backgroundColor: UIColor?

// Corner radius of the segments
// default: 6
@IBInspectable public var segmentsCornerRadius: CGFloat

// Determines whether there should be a short fade animation when selecting a segment
// default: true
@IBInspectable public var animateStateChange: Bool

// Background color of the selected segment
// default: .blue-ish (#389FF9)
@IBInspectable public var selectedBackgroundColor: UIColor

// Text color of the selected segment
// default: .white
@IBInspectable public var selectedTextColor: UIColor

// Background color of the deselected segment
// default: .clear
@IBInspectable public var deselectedBackgroundColor: UIColor

// Text color of the deselected segment
// default: .black
@IBInspectable public var deselectedTextColor: UIColor
```

There are many different ways to style a control with given options, here is a few examples:

<img src="https://github.com/LinusGeffarth/LGSegmentedControl/blob/master/screenshots/ss3.png" height="600"/>

## Contribution

If you find any bugs, please [open a new issue](https://github.com/LinusGeffarth/LGSegmentedControl/issues/new).  
If you want to contribute changes and features, please [open a pull request](https://github.com/LinusGeffarth/LGSegmentedControl/compare) and I'll happily merge it!

## Author

LGSegmentedControl is written and maintained by Linus Geffarth (me). If you want to say hi, reach out to me via twitter [@linusgeffarth](https://twitter.com/linusgeffarth), or email [linus@geffarth.com](mailto:linus@geffarth.com).

## License

LGSegmentedControl is available under the MIT license. See the LICENSE file for more info.
