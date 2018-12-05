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
        return view
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tapView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
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
    
    var delegate: LGSegmentDelegate?
    
    public init(title: String) {
        self.title = title
        
        updateAppearance(animated: false)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backgroundView.addSubview(titleLabel)
        contentView.addSubview(backgroundView)
        contentView.addSubview(tapView)
        
        backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        
        tapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tapView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.layoutIfNeeded()
    }
    
    func updateAppearance(animated: Bool? = nil) {
        UIView.animate(withDuration: animated ?? _animateStateChange ? 0.1 : 0) {
            // status-related
            self.titleLabel.textColor = self.state.labelColor
            self.backgroundView.backgroundColor = self.state.backgroundColor
            // others
            self.backgroundView.layer.cornerRadius = _segmentsCornerRadius
            self.titleLabel.font = _font
        }
    }
    
    @objc private func handleTap() {
        delegate?.didSelect(self)
    }
    
    public func set(state: State, animated: Bool? = nil) {
        self._state = state
        updateAppearance(animated: animated)
    }
}

extension LGSegment: Equatable {
    public enum State {
        case selected
        case deselected
        
        var labelColor: UIColor {
            switch self {
            case .selected:
                return _selectedColor.text
            case .deselected:
                return _deselectedColor.text
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .selected:
                return _selectedColor.background
            case .deselected:
                return _deselectedColor.background
            }
        }
    }
    
    public static func == (lhs: LGSegment, rhs: LGSegment) -> Bool {
        return lhs.contentView == rhs.contentView
    }
}
