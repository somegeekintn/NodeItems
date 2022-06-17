//
//  SymbolSource.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

struct SymbolSource: SourceItemData {
    var name            : String
    var title           : String { "SF Symbol: \(name)" }
    var headerTitle     : String { "SourceItemData Type: \(type(of: self))" }
    var imageDesc       : SourceImageDesc { .symbol(systemName: name) }
}
