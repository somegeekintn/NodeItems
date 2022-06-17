//
//  SourceItemData.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

protocol SourceItemData {
    associatedtype Content  : View
    associatedtype Header   : View
    
    @ViewBuilder var header     : Self.Header { get }
    @ViewBuilder var content    : Self.Content { get }

    var title           : String { get }
    var headerTitle     : String { get }
    var imageDesc       : SourceImageDesc { get }
}

extension SourceItemData {
    var headerTitle     : String { title }
    var icon            : NSImage? { nil }
    var imageDesc       : SourceImageDesc { .symbol() }

    var header          : some View { Text("Unimplemented \(sourceType).header") }
    var content         : some View { Text("Unimplemented \(sourceType).content") }
    var sourceType      : String { "\(type(of: self))" }
   
    func with<Item: SourceItem>(@SourceBuilder children: () -> SourceListVal<Item>) -> (data: Self, items: [Item]) {
        return (self, children().items)
    }
}

enum SourceImageDesc {
    case icon(nsImage: NSImage)
    case symbol(systemName: String = "questionmark.circle", color: Color = .primary)
}

extension Never: SourceItemData {
    var headerTitle     : String { fatalError () }
    var imageDesc       : SourceImageDesc { SourceImageDesc.symbol(systemName: "exclamationmark.octagon", color: .red) }
    var header          : some View { Text("Error: Never SourceItemData type cannot provide header") }
    var content         : some View { Text("Error: Never SourceItemData type cannot provide content") }
}
