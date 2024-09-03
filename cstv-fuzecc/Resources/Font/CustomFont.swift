//
//  CustomFont.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation
import SwiftUI

enum CustomFont: String {
    case roboto = "Roboto"
}

enum CustomFontStyle: String {
    case bold = "-Bold"
    case regular = "-Regular"
}

extension Font {
    static func customFont(
        font: CustomFont = .roboto,
        style: CustomFontStyle = .regular,
        size: CGFloat = 16,
        relativeTo: Font.TextStyle? = nil) -> Font {
            let font = font.rawValue + style.rawValue
            
            if let relative = relativeTo {
                return Font.custom(font, size: 16, relativeTo: relative)
            }
            
            return Font.custom(font, size: size)
        }
}
