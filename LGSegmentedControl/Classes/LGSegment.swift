//
//  LGSegment.swift
//  LGSegmentedControl
//
//  Created by Linus Geffarth on 05.12.18.
//

import UIKit

public
class LGSegment {
    
    var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        view.backgroundColor = .clear
        view.layer.zPosition = 0
        return view
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.zPosition = 1
        return view
    }()
    lazy var badgeView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        view.backgroundColor = options.badgeColor.background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.zPosition = 2
        return view
    }()
    lazy var badgeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        label.textColor = options.badgeColor.text
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var tapView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        view.layer.zPosition = 3
        return view
    }()
    
    private var _state: State = .deselected
    public var state: State { return _state }
    
    public var title: String? {
        get { return titleLabel.text }
        set {
            titleLabel.text = newValue
            titleLabel.sizeToFit()
        }
    }
    
    var options = LGSegmentOptions()
    
    public var badgeCount: Int? {
        didSet {
            updateAppearance(with: options)
        }
    }
    
    var delegate: LGSegmentDelegate?
    
    public init(title: String, badgeCount: Int? = nil) {
        self.title = title
        self.badgeCount = badgeCount
        
        updateAppearance(with: options, animated: false)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backgroundView.addSubview(titleLabel)
        badgeView.addSubview(badgeLabel)
        contentView.addSubview(badgeView)
        contentView.addSubview(backgroundView)
        contentView.addSubview(tapView)
        
        backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: backgroundView.leadingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: backgroundView.trailingAnchor, constant: 12).isActive = true
        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: backgroundView.topAnchor, constant: 6).isActive = true
        titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: backgroundView.bottomAnchor, constant: 6).isActive = true
        
        badgeLabel.centerYAnchor .constraint(equalTo: badgeView.centerYAnchor).isActive = true
        badgeLabel.leadingAnchor .constraint(equalTo: badgeView.leadingAnchor , constant:   4).isActive = true
        badgeLabel.trailingAnchor.constraint(equalTo: badgeView.trailingAnchor, constant:  -4).isActive = true
        badgeLabel.topAnchor     .constraint(equalTo: badgeView.topAnchor,      constant: 0.5).isActive = true
        badgeLabel.bottomAnchor  .constraint(equalTo: badgeView.bottomAnchor,   constant:-0.5).isActive = true
        
        badgeView.leadingAnchor  .constraint(equalTo: titleLabel.trailingAnchor, constant: 0).isActive = true
        badgeView.bottomAnchor   .constraint(equalTo: titleLabel.topAnchor     , constant:  6).isActive = true
        let badgeViewSize: CGFloat = 16
        badgeView.heightAnchor   .constraint(greaterThanOrEqualToConstant: badgeViewSize).isActive = true
        badgeView.widthAnchor    .constraint(greaterThanOrEqualToConstant: badgeViewSize).isActive = true
        badgeView.layer.cornerRadius = badgeViewSize/2

        tapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tapView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.layoutIfNeeded()
    }
    
    func updateAppearance(with options: LGSegmentOptions, animated: Bool? = nil) {
        self.options = options
        UIView.animate(withDuration: animated ?? options.animateStateChange ? 0.1 : 0) {
            // status-related
            self.titleLabel.textColor = self.textColor
            self.backgroundView.backgroundColor = self.backgroundColor
            // others
            self.backgroundView.layer.cornerRadius = options.cornerRadius
            self.titleLabel.font = options.font
            self.badgeView.isHidden = self.badgeCount == nil
        }
        badgeLabel.text = badgeCount?.string ?? ""
    }
    
    @objc private func handleTap() {
        delegate?.didSelect(self)
    }
    
    public func set(state: State, animated: Bool? = nil) {
        self._state = state
        updateAppearance(with: options, animated: animated)
    }
}

extension LGSegment: Equatable {
    public enum State {
        case selected
        case deselected
    }
    
    var textColor: UIColor {
        switch self.state {
        case .selected:
            return options.selectedColor.text
        case .deselected:
            return options.deselectedColor.text
        }
    }
    
    var backgroundColor: UIColor {
        switch self.state {
        case .selected:
            return options.selectedColor.background
        case .deselected:
            return options.deselectedColor.background
        }
    }

    public static func == (lhs: LGSegment, rhs: LGSegment) -> Bool {
        return lhs.contentView == rhs.contentView
    }
}
