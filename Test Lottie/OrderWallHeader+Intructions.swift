//
//  OrderWallHeader+Intructions.swift
//  Test Lottie
//
//  Created by Aleksandr Khalupa on 30.08.2021.
//

import Foundation
import UIKit

protocol LearnMoreDelegate: AnyObject  {
    func didLearnMorePressed()
}

extension OrderWallHeaderVC {
    class Instructions: UIView {
        weak var delegate: LearnMoreDelegate?
        private let titleLabel = UILabel(.color(UIColor.black),
                                         .font(.sfPro(.display, 32, .bold)),
                                         .numberOfLines(0),
                                         .huggPrio(.required, .vertical),
                                         .compResiPrio(.defaultLow, .horizontal),
                                         .lineBreakMode(.byWordWrapping),
                                         .text(""))
        
        private let imageView = UIImageView(.contentMode(.scaleAspectFit), .image("reorder_hero_image"))
        private let learnMoreButton = UIButton(.font(.sfPro(.text, 14, .regular)),.titleColor(.link, .normal),.backgroundColor(UIColor.clear),.localized("order_orderwall_banner_button", .normal))
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubView()
            addConstrains()
            learnMoreButton.addTarget(self, action: #selector(learnMorePressed), for: .touchUpInside)
            learnMoreButton.setTitle("title of button", for: .normal)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func learnMorePressed() {
            delegate?.didLearnMorePressed()
        }
        
        func addSubView() {
            addSubview(imageView)
            addSubview(titleLabel)
            addSubview(learnMoreButton)
        }
        
        func addConstrains() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            learnMoreButton.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.handleInsets([.top(0), .trailing(0), .width(140), .height(140)], superView: self, priority: .required)
            titleLabel.handleInsets([.top(24), .leading(24), .constraint(titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor))], superView: self, priority: .required)
            learnMoreButton.setContentCompressionResistancePriority(.required, for: .vertical)
            learnMoreButton.handleInsets([
                .constraint(learnMoreButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0)),
                .leading(24),
                .bottom(-28),
                .height(36),
            ], superView: self, priority: .required)
        }
    }
}
