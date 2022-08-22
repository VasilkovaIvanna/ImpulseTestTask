//
//  UIKitExtensions.swift
//  ImpulseTestTask
//
//  Created by Ivy on 22.08.2022.
//

import Foundation
import UIKit

extension UIFont {
    class var interFontRegular: UIFont? { UIFont(name: "Inter-Regular", size: 16) }
    class var interFontSemiBold: UIFont? { UIFont(name: "Inter-SemiBold", size: 16) }
    class var interFontBold: UIFont? { UIFont(name: "Inter-Bold", size: 16) }
}

extension UIColor {
    class var accentColor: UIColor? { UIColor(named: "AccentColor") }
    class var backgroundPrimary: UIColor? { UIColor(named: "BackgroundPrimary") }
    class var backgroundSecondary: UIColor? { UIColor(named: "BackgroundSecondary") }
}
