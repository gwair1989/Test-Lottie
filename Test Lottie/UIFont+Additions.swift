//
//  UIFont+Additions.swift
//  Test Lottie
//
//  Created by Aleksandr Khalupa on 30.08.2021.
//


import UIKit


extension UIFont {
    
    class var headline1: UIFont {
        return UIFont.fontWith(size: 34, family: .SFProDisplay, weight: .bold)
    }
    
    class var description1: UIFont {
        return UIFont.fontWith(size: 14, family: .SFProText, weight: .regular)
    }
    
    class var body: UIFont {
        return UIFont.fontWith(size: 17, family: .SFProDisplay, weight: .regular)
    }
    
    class var headline2: UIFont {
        return UIFont.fontWith(size: 22, family: .SFProDisplay, weight: .semibold)
    }
    
    class var headline3: UIFont {
        return UIFont.fontWith(size: 19, family: .SFProDisplay, weight: .medium)
    }
    
    class var subhead: UIFont {
        return UIFont.fontWith(size: 15, family: .SFProText, weight: .semibold)
    }
    
    class var subhead17: UIFont {
        return UIFont.fontWith(size: 17, family: .SFProText, weight: .semibold)
    }
    
    class var iosBody: UIFont {
        return UIFont.fontWith(size: 17, family: .SFProText, weight: .regular)
    }
    
    class var footnote: UIFont {
        return UIFont.fontWith(size: 12, family: .SFProText, weight: .regular)
    }
    
    class var button: UIFont {
        return UIFont.fontWith(size: 17, family: .SFProText, weight: .semibold)
    }
    
    //FIXME: Not proper names.
    
    class var subheadLoyaltyAnimation: UIFont {
        return UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    }
    
    class var headlineLoyaltyAnimation: UIFont {
        return UIFont.systemFont(ofSize: 32.0, weight: .bold)
    }
    
    class var filter: UIFont {
        return UIFont.fontWith(size: 12, family: .SFProText, weight: .medium)
    }
    
    class var BodyNumericCode: UIFont {
        return UIFont.systemFont(ofSize: 48.0, weight: .bold)
    }
    
    class var buttonTitle: UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .semibold)
    }
    
    enum FontFamily: String {
        case SFProDisplay = "SFProDisplay"
        case SFProText = "SFProText"
        case Speedee = "SpeedeeApp"
    }
    
    static func fontWith(size: CGFloat, family: FontFamily, weight: UIFont.Weight) -> UIFont {
        let weightString: String
        switch weight {
        case .bold:
            weightString = "-Bold"
        case .medium:
            weightString = "-Medium"
        case .semibold:
            weightString = "-Semibold"
        case .regular:
            weightString = "-Regular"
        default:
            weightString = "-Regular"
        }
        
        let fontName = "\(family.rawValue)\(weightString)"
        if let font = UIFont(name: fontName, size: size) {
            return font
        } else {
//            assertionFailure()
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
    
}
