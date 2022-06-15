//
//  StringSource.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

struct StringSource: SourceItemData {
    var id              : String { title }
    var value           : String
    var title           : String { "String: \(value)" }
    var headerTitle     : String { "SourceItemData Type: \(type(of: self))" }
    var imageName       : String { "textformat.abc" }
    var imageStyle      : SourceImage.Style { .symbol(color: .primary) }
}
