//
//  IntSource.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

extension Int: SourceItemData {
    var title           : String { "Int: \(self)" }
    var headerTitle     : String { "SourceItemData Type: \(type(of: self))" }
    var imageName       : String { "number" }
    var imageStyle      : SourceImage.Style {
                            let colors : [Color] = [.red, .yellow, .green, .cyan, .blue, .purple]
                            
                            return .symbol(color: colors[self % colors.endIndex])
                        }
}
