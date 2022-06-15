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

    var id              : String { get }
    var title           : String { get }
    var headerTitle     : String { get }
    var imageName       : String { get }
    var imageStyle      : SourceImage.Style { get }
    var icon            : NSImage? { get }
}

extension SourceItemData {
    var headerTitle     : String { title }
    var icon            : NSImage? { nil }
}

extension Never: SourceItemData {
    var headerTitle     : String { fatalError () }
    var imageStyle      : SourceImage.Style { fatalError () }
    var header          : some View { Text("Error: Never SourceItemData type cannot provide header") }
    var content         : some View { Text("Error: Never SourceItemData type cannot provide content") }
}
