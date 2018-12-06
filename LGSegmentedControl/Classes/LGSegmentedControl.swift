//
//  LGSegmentedControl.swift
//  LGSegmentedControl
//
//  Created by Linus Geffarth on 26.11.18.
//

import UIKit

protocol LGSegmentDelegate {
    func didSelect(_ segment: LGSegment)
}
@IBDesignable public
class LGSegmentedControl: UIControl, LGSegmentDelegate {
    
    // MARK: - Outlet Connections
    
    private var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        view.backgroundColor = .clear
        return view
    }()
    private var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    
    private let options = LGSegmentOptions()
    
    public override var isEnabled: Bool {
        didSet {
            self.alpha = isEnabled ? 1 : 0.7
        }
    }
    
    /// Segments in the control
    public var segments: [LGSegment] = [] {
        didSet {
            segments.forEach { $0.delegate = self }
            // remove all other segments
            stackView.removeAllArrangedSubviews()
            // add all new segments
            stackView.add(arrangedSubviews: segments.map { $0.contentView })
            // reset previous selected index, b/c we're starting over with a new set of segments
            previousSelectedIndex = nil
            selectedIndex = initialSelectedIndex
        }
    }
    
    @IBInspectable
    private var initialSelectedIndex: Int = 0 {
        didSet { selectedIndex = initialSelectedIndex }
    }
    private var previousSelectedIndex: Int?
    /// Index of the currently selected segment. Setting this to `nil` will deselect all segments.
    public var selectedIndex: Int? {
        set { updateSelection(for: newValue) }
        get { return segments.firstIndex(where: { $0.state == .selected }) }
    }
    /// The currently selected segment. `nil`, if no segment is selected
    public var selectedSegment: LGSegment? {
        guard let index = selectedIndex else { return nil }
        return segments[safe: index]
    }
    
    // MARK: - Setup
    
    private func commonInit() {
        addSubview(contentView)
        contentView.frame = bounds
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func setupConstraints() {
        contentView.addSubview(stackView)
        
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.layoutIfNeeded()
    }
    
    // MARK: - UI
    
    private func updateSelection(for index: Int?, animated: Bool? = nil) {
        // do nothing when the same segment is tapped
        // to prevent seemingly "buggy" animations
        guard index != previousSelectedIndex else { return }
        previousSelectedIndex = index
        segments.forEach { $0.set(state: .deselected, animated: animated) }
        guard let i = index, let segment = segments[safe: i] else {
            // preventing unnecessary error statements when there are no segments
            // such as when the control is initializing and setting the initial index
            // and also not warning when selectedIndex is nil, b/c that may be intended
            guard !segments.isEmpty, selectedIndex != nil else { return }
            print("ERROR: cannot set selected index = \(index ??? "nil"), reason: index out of bounds (\(segments.count)) - LGSegmentedControl")
            return
        }
        segment.set(state: .selected, animated: animated)
    }
    
    fileprivate func updateAppearance(animated: Bool? = nil) {
        segments.forEach { $0.updateAppearance(with: options, animated: animated) }
    }
    
    func didSelect(_ segment: LGSegment) {
        guard isEnabled else { return }
        selectedIndex = segments.index(of: segment)
        sendActions(for: .valueChanged)
    }
    
    // MARK: - Customization & IBInspectables
    
    public var distribution: UIStackView.Distribution = .fill {
        didSet {
            stackView.distribution = distribution
        }
    }
    
    @IBInspectable
    private var segmentTitles: String {
        get {
            return segments.reduce("", { (result, element) in
                return result + ", " + (element.title ?? "")
            })
        }
        set {
            let titles = newValue.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            segments = titles.map { LGSegment(title: $0) }
        }
    }
    // private b/c only used for interface builder
    // `distribution` actually handles the setting
    /// StackView distribution, set to .fill to have each segment be as wide as required; set to .fillEqually, to have all segments be the same width, default: .fill
    @IBInspectable
    private var stackViewDistribution: String {
        get { return distribution.string }
        set { distribution = UIStackView.Distribution(newValue) ?? .fillEqually }
    }
    /// StackView spacing, default: 8
    @IBInspectable
    public var spacing: CGFloat {
        get { return stackView.spacing }
        set { stackView.spacing = newValue }
    }
    @IBInspectable
    override public var backgroundColor: UIColor? {
        get { return contentView.backgroundColor }
        set { contentView.backgroundColor = newValue }
    }
    /// Segments' corner radius, default: 6
    @IBInspectable
    public var segmentsCornerRadius: CGFloat {
        get { return options.cornerRadius }
        set { options.cornerRadius = newValue; updateAppearance() }
    }
    /// Determines whether there should be a short fade animation when selecting a segment, default: true
    @IBInspectable
    public var animateStateChange: Bool {
        get { return options.animateStateChange }
        set { options.animateStateChange = newValue; updateAppearance() }
    }
    /// Background color of the selected segment, default: .blue-ish (#389FF9)
    @IBInspectable
    public var selectedBackgroundColor: UIColor {
        get { return options.selectedColor.background }
        set { options.selectedColor.background = newValue; updateAppearance() }
    }
    /// Text color of the selected segment, default: .white
    @IBInspectable
    public var selectedTextColor: UIColor {
        get { return options.selectedColor.text }
        set { options.selectedColor.text = newValue; updateAppearance() }
    }
    /// Background color of the selected segment, default: .clear
    @IBInspectable
    public var deselectedBackgroundColor: UIColor {
        get { return options.deselectedColor.background }
        set { options.deselectedColor.background = newValue; updateAppearance() }
    }
    /// Text color of the selected segment, default: .black
    @IBInspectable
    public var deselectedTextColor: UIColor {
        get { return options.deselectedColor.text }
        set { options.deselectedColor.text = newValue; updateAppearance() }
    }
}
