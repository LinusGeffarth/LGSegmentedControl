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
class LGSegmentedControl: UIView, LGSegmentDelegate {
    
    // MARK: - Outlet Connections
    
    private var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        view.backgroundColor = .clear
        return view
    }()
    private var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    
    /// Segments in the control
    public var segments: [LGSegment] = [] {
        didSet {
            segments.forEach { $0.delegate = self }
            // remove all other segments
            stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }
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
    
    public var distribution: UIStackView.Distribution = .fillEqually {
        didSet {
            stackView.distribution = distribution
        }
    }
    
    // MARK: - Setup
    
    private func commonInit() {
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
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
        
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.layoutIfNeeded()
    }
    
    // MARK: - UI
    
    func updateSelection(for index: Int?, animated: Bool? = nil) {
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
    
    func updateAppearance(animated: Bool? = nil) {
        segments.forEach { $0.updateAppearance(animated: animated) }
    }
    
    func didSelect(_ segment: LGSegment) {
        selectedIndex = segments.index(of: segment)
    }
}

// MARK: - IBInspectables

extension LGSegmentedControl {
    
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
    
    @IBInspectable
    private var stackViewDistribution: String {
        get { return distribution.string }
        set { distribution = UIStackView.Distribution(newValue) ?? .fillEqually }
    }
    
    @IBInspectable
    public var spacing: CGFloat {
        get { return stackView.spacing }
        set { stackView.spacing = newValue }
    }
    
    @IBInspectable
    public var segmentsCornerRadius: CGFloat {
        get { return _segmentsCornerRadius }
        set { _segmentsCornerRadius = newValue; updateAppearance() }
    }
    @IBInspectable
    public var animateStateChange: Bool {
        get { return _animateStateChange }
        set { _animateStateChange = newValue; updateAppearance() }
    }
    @IBInspectable
    public var selectedBackgroundColor: UIColor {
        get { return _selectedColor.background }
        set { _selectedColor.background = newValue; updateAppearance() }
    }
    @IBInspectable
    public var selectedTextColor: UIColor {
        get { return _selectedColor.text }
        set { _selectedColor.text = newValue; updateAppearance() }
    }
    @IBInspectable
    public var deselectedBackgroundColor: UIColor {
        get { return _deselectedColor.background }
        set { _deselectedColor.background = newValue; updateAppearance() }
    }
    @IBInspectable
    public var deselectedTextColor: UIColor {
        get { return _deselectedColor.text }
        set { _deselectedColor.text = newValue; updateAppearance() }
    }
}
