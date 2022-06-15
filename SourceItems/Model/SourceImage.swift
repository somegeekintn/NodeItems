//
//  SourceImage.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

struct SourceImage {
    enum Style {
        case icon
        case symbol(color: Color)
    }
    
    let image   : Image
    let style   : Style
}

extension Image {
    func with(style: SourceImage.Style) -> SourceImage {
        SourceImage(image: self, style: style)
    }
}
