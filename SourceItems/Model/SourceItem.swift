//
//  SourceItem.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/14/22.
//

import SwiftUI

protocol SourceItem: Identifiable {
    associatedtype Model    : SourceItemData
    associatedtype Child    : SourceItem

    var id              : String { get }
    var data            : Model { get }
    var children        : [Child]? { get }
}

extension SourceItem {
    var customImgDesc   : SourceImageDesc? { nil }

    var title           : String { data.title }
    var headerTitle     : String { data.headerTitle }
    var header          : some View { data.header }
    var content         : some View { data.content }
    var imageDesc       : SourceImageDesc { customImgDesc ?? data.imageDesc }
}

struct SourceItemVal<Model: SourceItemData, Child: SourceItem>: SourceItem {
    var id          = UUID().uuidString
    var data        : Model
    var children    : [Child]?
}

extension Never: SourceItem {
    public var id       : String   { "ERROR" }
    public var data     : Never    { fatalError() }
    public var children : [Never]? { fatalError() }
}
