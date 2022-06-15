//
//  IntSource.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

struct IntSource: SourceItemData {
    var id              : String { title }
    var value           : Int
    var title           : String { "Int: \(value)" }
    var headerTitle     : String { "SourceItemData Type: \(type(of: self))" }
    var imageName       : String { "number" }
    var imageStyle      : SourceImage.Style {
                            let colors : [Color] = [.red, .yellow, .green, .cyan, .blue, .purple]
                            
                            return .symbol(color: value < colors.endIndex ? colors[value] : .primary)
                        }
}

