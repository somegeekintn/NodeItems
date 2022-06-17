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
    var imageDesc       : SourceImageDesc {
                            let colors : [Color] = [.red, .yellow, .green, .cyan, .blue, .purple]
                            
                            return .symbol(systemName: "number", color: colors[self % colors.endIndex])
                        }
}
