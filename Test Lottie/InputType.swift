//
//  InputType.swift
//  Test Lottie
//
//  Created by Aleksandr Khalupa on 30.08.2021.
//

import Foundation
import UIKit


enum SupportedFonts {
    enum SFPro {
        case text
        case display

        var converted: UIFont.FontFamily {
            switch self {
            case .text:
                return .SFProText
            case .display:
                return .SFProDisplay
            }
        }
    }
    
    enum Speedee {
        case app
        
        var converted: UIFont.FontFamily {
            switch self {
            case .app:
                return .Speedee
            }
        }
    }

    case sfPro(SFPro, CGFloat, UIFont.Weight)
    case speedee(Speedee, CGFloat, UIFont.Weight)

    var font: UIFont {
        switch self {
        case .sfPro(let family, let size, let weight):
            return UIFont.fontWith(size: size, family: family.converted, weight: weight)
        case .speedee(let family, let size, let weight):
            return UIFont.fontWith(size: size, family: family.converted, weight: weight)
        }
    }
}

extension UILabel {
    enum LabelInputType {
        case uiFont(UIFont)
        case font(SupportedFonts)
        case color(UIColor)
        case text(String)
        case textAlignment(NSTextAlignment)
        case numberOfLines(Int)
        case background(UIColor)
        case localized(String)
        case lineBreakMode(NSLineBreakMode)
        case huggPrio(UILayoutPriority, NSLayoutConstraint.Axis)
        case compResiPrio(UILayoutPriority, NSLayoutConstraint.Axis)
        case userInteractionEnabled(Bool)
    }

    convenience init(_ type: UILabel.LabelInputType...) {
        self.init(frame: .zero)
        type.forEach { input in
            switch input {
            case .font(let value):
                font = value.font
            case .uiFont(let value):
                font = value
            case .color(let value):
                textColor = value
            case .text(let value):
                text = value
            case .textAlignment(let value):
                textAlignment = value
            case .numberOfLines(let value):
                numberOfLines = value
            case .background(let value):
                backgroundColor = value
            case .localized(let value):
                text = ""
            case .lineBreakMode(let value):
                lineBreakMode = value
            case .huggPrio(let prio, let axis):
                setContentHuggingPriority(prio, for: axis)
            case .compResiPrio(let prio, let axis):
                setContentCompressionResistancePriority(prio, for: axis)
            case .userInteractionEnabled(let isInteractionEnabled):
                isUserInteractionEnabled = isInteractionEnabled
            }
        }
    }
}

extension UITextView {
    enum TextViewInputType {
        case uiFont(UIFont)
        case font(SupportedFonts)
        case color(UIColor)
        case text(String)
        case isScrollEnabled(Bool)
        case isUserInteractionEnabled(Bool)
        case isEditable(Bool)
        case dataDetectorTypes(UIDataDetectorTypes)
        case isSelectable(Bool)
        case textAlignment(NSTextAlignment)
        case keyboard(UIKeyboardType)
        case textContentType(UITextContentType)
        case background(UIColor)
        case huggPrio(UILayoutPriority, NSLayoutConstraint.Axis)
        case compResiPrio(UILayoutPriority, NSLayoutConstraint.Axis)
        case textContainerInset(UIEdgeInsets)
        case lineFragmentPadding(CGFloat)
    }

    convenience init(_ type: UITextView.TextViewInputType...) {
        self.init(frame: .zero, textContainer: nil)
        backgroundColor = .clear // TODO: make default values instead of setting this here.
        type.forEach { input in
            switch input {
            case .font(let value):
                font = value.font
            case .uiFont(let value):
                font = value
            case .color(let value):
                textColor = value
            case .text(let value):
                text = value
            case .isScrollEnabled(let value):
                isScrollEnabled = value
            case .isUserInteractionEnabled(let value):
                isUserInteractionEnabled = value
            case .isEditable(let value):
                isEditable = value
            case .dataDetectorTypes(let value):
                dataDetectorTypes = value
            case .isSelectable(let value):
                isSelectable = value
            case .textAlignment(let value):
                textAlignment = value
            case .keyboard(let value):
                keyboardType = value
            case .textContentType(let value):
                textContentType = value
            case .background(let value):
                backgroundColor = value
            case .huggPrio(let prio, let axis):
                setContentHuggingPriority(prio, for: axis)
            case .compResiPrio(let prio, let axis):
                setContentCompressionResistancePriority(prio, for: axis)
            case .lineFragmentPadding(let value):
                textContainer.lineFragmentPadding = value
            case .textContainerInset(let value):
                textContainerInset = value
            }
        }
    }
}

extension UIButton {
    enum ButtonInputType {
        case title(_ title: String, _ state: UIControl.State = .normal)
        case font(SupportedFonts)
        case titleColor(_ color: UIColor, _ state: UIControl.State = .normal)
        case backgroundColor(UIColor)
        case isFullscreen(Bool)
        case textAlignment(NSTextAlignment)
        case contentHorizontalAlignment(UIControl.ContentHorizontalAlignment)
        case backgroundImage(UIImage?)
        case cornerRadius(CGFloat)
        case borderWidth(CGFloat)
        case borderColor(UIColor)
        case image(_ image: UIImage?, _ state: UIControl.State = .normal)
        case localized(String, _ state: UIControl.State = .normal)
        case numberOfLines(Int)
        case linebreak(NSLineBreakMode)
        case contentEdgeInsets(UIEdgeInsets)
        case huggPrio(UILayoutPriority, NSLayoutConstraint.Axis)
        case compResiPrio(UILayoutPriority, NSLayoutConstraint.Axis)
    }

    convenience init(_ type: UIButton.ButtonInputType...) {
        self.init(type: .custom)
        updateInputs(inputs: type)
    }

    func updateInputs(inputs: [UIButton.ButtonInputType]) {
        inputs.forEach { input in
            switch input {
            case .title(let title, let state):
                self.setTitle(title, for: state)
            case .titleColor(let color, let state):
                self.setTitleColor(color, for: state)
            case .font(let value):
                self.titleLabel?.font = value.font
            case .backgroundColor(let color):
                backgroundColor = color
            case .backgroundImage(let image):
                setBackgroundImage(image, for: .normal)
            case .isFullscreen(let isFullscreen):
                layer.cornerRadius = isFullscreen ? 0 : 8
            case .contentHorizontalAlignment(let value):
                contentHorizontalAlignment = value
            case .textAlignment(let value):
                titleLabel?.textAlignment = value
            case .cornerRadius(let value):
                layer.cornerRadius = value
            case .borderColor(let color):
                layer.borderColor = color.cgColor
            case .borderWidth(let value):
                layer.borderWidth = value
            case .image(let image, let state):
                setImage(image, for: state)
            case .localized(let value, let state):
                self.setTitle("", for: state)
            case .numberOfLines(let value):
                titleLabel!.numberOfLines = value
            case .linebreak(let value):
                titleLabel!.lineBreakMode = value
            case .contentEdgeInsets(let value):
                contentEdgeInsets = value
            case .huggPrio(let prio, let axis):
                setContentHuggingPriority(prio, for: axis)
            case .compResiPrio(let prio, let axis):
                setContentCompressionResistancePriority(prio, for: axis)
            }
        }
    }
}

//extension TextField {
//    enum InputType {
//        case text(String)
//        case font(SupportedFonts)
//        case placeholder(String)
//        case titleText(String)
//        case secure(Bool)
//        case keyboard(UIKeyboardType)
//        case textContentType(UITextContentType)
//        case background(UIColor)
//        case autoCapitalize(UITextAutocapitalizationType)
//    }
//
//    convenience init(_ type: [TextField.InputType]) {
//        self.init(viewModel: ViewModel(text: "", title: "", placeHolder: ""))
//        type.forEach { input in
//            switch input {
//            case .placeholder(let value):
//                viewModel.placeHolder.accept(value)
//            case .text(let value):
//                text = value
//            case .font(let value):
//                font = value.font
//            case .titleText(let value):
//                viewModel.title.accept(value)
//            case .secure(let value):
//                isSecureTextEntry = value
//            case .keyboard(let value):
//                keyboardType = value
//            case .textContentType(let value):
//                textContentType = value
//            case .background(let value):
//                backgroundColor = value
//            case .autoCapitalize(let value):
//                autocapitalizationType = value
//            }
//        }
//    }
//
//    convenience init(_ type: TextField.InputType...) {
//        self.init(type)
//    }
//
//    convenience init(_ type: AccountFieldType) {
//        self.init(type.inputs)
//    }
//}

extension UITextField {
    enum Input {
        case text(String)
        case font(SupportedFonts)
        case placeholder(String)
        case secure(Bool)
        case keyboard(UIKeyboardType)
        case textContentType(UITextContentType)
        case alignment(NSTextAlignment)
        case autoCapitalize(UITextAutocapitalizationType)
    }

    convenience init(_ type: [UITextField.Input]) {
        self.init(frame: .zero)
        type.forEach { input in
            switch input {
            case .placeholder(let value):
                placeholder = value
            case .text(let value):
                text = value
            case .font(let value):
                font = value.font
            case .secure(let value):
                isSecureTextEntry = value
            case .keyboard(let value):
                keyboardType = value
            case .textContentType(let value):
                textContentType = value
            case .alignment(let value):
                textAlignment = value
            case .autoCapitalize(let value):
                autocapitalizationType = value
            }
        }
    }

    convenience init(_ type: UITextField.Input...) {
        self.init(type)
    }
}

extension ListView {
    enum InputType {
        case axis(NSLayoutConstraint.Axis)
        case views([UIView])
        case backgroundColor(UIColor)
        case scrollable(Bool)
        case inset([Inset])
        case spacing(CGFloat)
        case alwaysBounceVertical(Bool)
        case distribution(UIStackView.Distribution)
        case alignment(UIStackView.Alignment)
        case cornerRadius(CGFloat)
        case borderWidth(CGFloat)
        case borderColor(UIColor)
        case setHuggPrio(UILayoutPriority, NSLayoutConstraint.Axis)
        case setCompResist(UILayoutPriority, NSLayoutConstraint.Axis)
    }

    convenience init(_ type: ListView.InputType...) {
        self.init(frame: .zero)
        type.forEach { input in
            switch input {
            case .axis(let value):
                axis = value
            case .views(let value):
                value.forEach { addView($0) }
            case .backgroundColor(let value):
                backgroundColor = value
            case .scrollable(let value):
                scrollable = value
            case .inset(let value):
                insets = value
            case .spacing(let value):
                stackView.spacing = value
            case .alwaysBounceVertical(let value):
                alwaysBounceVertical = value
            case .distribution(let value):
                stackView.distribution = value
            case .alignment(let value):
                stackView.alignment = value
            case .cornerRadius(let value):
                layer.cornerRadius = value
            case .borderColor(let color):
                layer.borderColor = color.cgColor
            case .borderWidth(let value):
                layer.borderWidth = value
            case .setHuggPrio(let prio, let axis):
                setContentHuggingPriority(prio, for: axis)
            case .setCompResist(let prio, let axis):
                setContentCompressionResistancePriority(prio, for: axis)
            }
        }
    }
}

enum Inset {
    case top(CGFloat = 0, Bool = false)
    case bottom(CGFloat = 0, Bool = false)
    case left(CGFloat = 0, Bool = false)
    case right(CGFloat = 0, Bool = false)
    case leading(CGFloat = 0, Bool = false)
    case trailing(CGFloat = 0, Bool = false)
    case width(CGFloat = 0)
    case height(CGFloat = 0)
    case constraint(NSLayoutConstraint)
    case centerX(CGFloat = 0)
    case centerY(CGFloat = 0)
    case heightGreater(CGFloat)
    case widthGreater(CGFloat)
    case heightless(CGFloat)
    case widthLess(CGFloat)

    static var fill: [Inset] = [.top(0), .bottom(0), .left(0), .right(0)]
}

extension UIView {
    func handleInsets(_ insets: [Inset], superView: UIView, priority: UILayoutPriority) {
        let mapped = insets.compactMap { (inset) -> NSLayoutConstraint in
            switch inset {
            case .top(let inset, let safeArea):
                if safeArea {
                    return topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: inset)
                } else {
                    return topAnchor.constraint(equalTo: superView.topAnchor, constant: inset)
                }
            case .bottom(let inset, let safeArea):
                if safeArea {
                    return bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: inset)
                } else {
                    return bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: inset)
                }
            case .left(let inset, let safeArea):
                if safeArea {
                    return leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor, constant: inset)
                } else {
                    return leftAnchor.constraint(equalTo: superView.leftAnchor, constant: inset)
                }
            case .right(let inset, let safeArea):
                if safeArea {
                    return rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor, constant: inset)
                } else {
                    return rightAnchor.constraint(equalTo: superView.rightAnchor, constant: inset)
                }
            case .leading(let inset, let safeArea):
                if safeArea {
                    return leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor, constant: inset)
                } else {
                    return leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset)
                }
            case .trailing(let inset, let safeArea):
                if safeArea {
                    return trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: inset)
                } else {
                    return trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: inset)
                }
            case .width(let width):
                return widthAnchor.constraint(equalToConstant: width)
            case .height(let height):
                return heightAnchor.constraint(equalToConstant: height)
            case .constraint(let constaint):
                return constaint
            case .centerX(let offset):
                return centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: offset)
            case .centerY(let offset):
                return centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: offset)
            case .heightGreater(let value):
                return heightAnchor.constraint(greaterThanOrEqualToConstant: value)
            case .widthGreater(let value):
                return widthAnchor.constraint(greaterThanOrEqualToConstant: value)
            case .heightless(let value):
                return heightAnchor.constraint(lessThanOrEqualToConstant: value)
            case .widthLess(let value):
                return widthAnchor.constraint(lessThanOrEqualToConstant: value)
            }
        }
        mapped.forEach { $0.priority = priority }
        NSLayoutConstraint.activate(mapped)
    }
}

extension UIControl {
    enum UIControlInput {
        case isEnabled(Bool)
        case isSelected(Bool)
        case isHighlighted(Bool)
    }

    convenience init(_ type: UIControl.UIControlInput...) {
        self.init(frame: .zero)
        type.forEach { input in
            switch input {
            case .isEnabled(let value):
                isEnabled = value
            case .isSelected(let value):
                isSelected = value
            case .isHighlighted(let value):
                isHighlighted = value
            }
        }
    }
}

extension UIView {
    enum UIViewInput {
        case backgroundColor(UIColor)
        case alpha(CGFloat)
        case cornerRadius(CGFloat)
        case borderWidth(CGFloat)
        case borderColor(UIColor)
        case userInteraction(Bool)
        case setHuggPrio(UILayoutPriority, NSLayoutConstraint.Axis)
        case setCompResist(UILayoutPriority, NSLayoutConstraint.Axis)
    }

    convenience init(_ type: UIView.UIViewInput...) {
        self.init(frame: .zero)
        type.forEach { input in
            switch input {
            case .backgroundColor(let value):
                backgroundColor = value
            case .alpha(let value):
                alpha = value
            case .cornerRadius(let value):
                layer.cornerRadius = value
            case .borderColor(let color):
                layer.borderColor = color.cgColor
            case .borderWidth(let value):
                layer.borderWidth = value
            case .userInteraction(let value):
                isUserInteractionEnabled = value
            case .setHuggPrio(let prio, let axis):
                setContentHuggingPriority(prio, for: axis)
            case .setCompResist(let prio, let axis):
                setContentCompressionResistancePriority(prio, for: axis)
            }
        }
    }
}

extension UIStackView {
    enum UIStackViewInput {
        case axis(NSLayoutConstraint.Axis)
    }

    convenience init(_ type: UIStackView.UIStackViewInput...) {
        self.init(frame: .zero)
        type.forEach { input in
            switch input {
            case .axis(let value):
                axis = value
            }
        }
    }
}

extension UIActivityIndicatorView {
    enum UIActivityIndicatorInput {
        case animating
        case style(UIActivityIndicatorView.Style)
        case hidesWhenStopped(Bool)
    }

    convenience init(_ type: UIActivityIndicatorView.UIActivityIndicatorInput...) {
        self.init(style: .gray)
        type.forEach { input in
            switch input {
            case .animating:
                startAnimating()
            case .style(let value):
                style = value
            case .hidesWhenStopped(let value):
                hidesWhenStopped = value
            }
        }
    }
}

extension UIImageView {
    enum UIImageViewInput {
        case image(String)
        case contentMode(UIView.ContentMode)
        case setHuggPrio(UILayoutPriority, NSLayoutConstraint.Axis)
        case setCompResist(UILayoutPriority, NSLayoutConstraint.Axis)
    }

    convenience init(_ type: UIImageView.UIImageViewInput...) {
        self.init(frame: .zero)
        type.forEach { input in
            switch input {
            case .image(let value):
                image = UIImage(named: value)
            case .contentMode(let value):
                contentMode = value
            case .setHuggPrio(let prio, let axis):
                setContentHuggingPriority(prio, for: axis)
            case .setCompResist(let prio, let axis):
                setContentCompressionResistancePriority(prio, for: axis)
            }
        }
    }
}

extension UIView {
    func fill(superView: UIView, safeArea: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        activateConstraints(
            topAnchor.constraint(equalTo: safeArea ? superView.safeAreaLayoutGuide.topAnchor : superView.topAnchor),
            leftAnchor.constraint(equalTo: superView.leftAnchor),
            rightAnchor.constraint(equalTo: superView.rightAnchor),
            bottomAnchor.constraint(equalTo:  safeArea ? superView.safeAreaLayoutGuide.bottomAnchor : superView.bottomAnchor)
        )
    }
    
    
    func activateConstraints(_ constraints: NSLayoutConstraint...) {
        NSLayoutConstraint.activate(constraints)
    }
}


