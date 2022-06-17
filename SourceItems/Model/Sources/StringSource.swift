//
//  StringSource.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

extension String: SourceItemData {
    var title           : String { "String: \(self)" }
    var headerTitle     : String { "SourceItemData Type: \(type(of: self))" }
    var imageDesc       : SourceImageDesc { .symbol(systemName: "textformat.abc") }
}
