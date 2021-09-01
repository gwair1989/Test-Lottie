//
//  ListView.swift
//  Test Lottie
//
//  Created by Aleksandr Khalupa on 30.08.2021.
//

import UIKit

class ListView: UIScrollView {
    

        let stackView = UIStackView()
        var insets: [Inset]?

        var scrollable = true {
            didSet {
                updateConstraint()
            }
        }

        var touchesShouldCancelOnUIButton = false

        private lazy var verticalConstraint: NSLayoutConstraint = {
            stackView.widthAnchor.constraint(equalTo: widthAnchor)
        }()

        private lazy var horizontalConstraint: NSLayoutConstraint = {
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
        }()

        var axis: NSLayoutConstraint.Axis = .horizontal {
            didSet {
                stackView.axis = self.axis
                updateConstraint()
            }
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = UIColor.white
            setup()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }

        private func setup() {
            contentInsetAdjustmentBehavior = .never
            showsVerticalScrollIndicator = false
            showsHorizontalScrollIndicator = false
            addSubview(stackView)
            stackView.fill(superView: self, safeArea: false)
            updateConstraint()
            alwaysBounceVertical = true
        }

        private func updateConstraint() {
            if scrollable == false {
                horizontalConstraint.isActive = true
                verticalConstraint.isActive = true
                return
            }

            horizontalConstraint.isActive = axis == .horizontal
            verticalConstraint.isActive = axis == .vertical
        }

        @discardableResult func addView(_ view: UIView, _ insets: Inset..., spacing: CGFloat = 0, zPosition: CGFloat = 0) -> UIView{
            return addView(view, insets: insets, spacing: spacing, zPosition: zPosition)
        }

        @discardableResult func addView(_ view: UIView, insets: [Inset], spacing: CGFloat = 0, zPosition: CGFloat = 0) -> UIView {
            let content = ContentView(view: view)

            content.translatesAutoresizingMaskIntoConstraints = false
            view.translatesAutoresizingMaskIntoConstraints = false
            content.isUserInteractionEnabled = view.isUserInteractionEnabled
            content.setContentHuggingPriority(.required, for: .vertical)
            view.handleInsets(Inset.fill, superView: content, priority: .defaultHigh)
            if let insets = self.insets {
                view.handleInsets(insets, superView: content, priority: .defaultHigh + 1)
            }
            view.handleInsets(insets, superView: content, priority: .defaultHigh + 2)

            stackView.addArrangedSubview(content)
            content.layer.zPosition = zPosition

            if spacing != 0 {
                stackView.setCustomSpacing(spacing, after: content)
            }
            return content
        }

        func clear() {
            stackView.arrangedSubviews.forEach {
                stackView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
        }

        override func touchesShouldCancel(in view: UIView) -> Bool {
            if touchesShouldCancelOnUIButton && view is UIButton {
                return true
            }
            return super.touchesShouldCancel(in: view)
        }
        
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            guard !isHidden, alpha > 0 else { return nil }
            for member in stackView.subviews.reversed() {
                let subPoint = member.convert(point, from: self)
                guard let result = member.hitTest(subPoint, with: event) else { continue }
                return result
            }
            return nil
        }
    }



    extension ListView {
        class ContentView: UIView {
            var observ: NSKeyValueObservation?
            @objc dynamic var contentView: UIView

            init(view: UIView) {
                contentView = view
                super.init(frame: view.bounds)
                addSubview(contentView)

                observ = observe(\.contentView.isHidden, options: .new) { [weak self] (viewm, value) in
                    guard let isHidden = value.newValue else { return }
                    self?.isHidden = isHidden
                }

            }

            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
    
    }


