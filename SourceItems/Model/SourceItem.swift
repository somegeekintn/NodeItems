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
    var customImageName : String? { nil }

    var title           : String { data.title }
    var headerTitle     : String { data.headerTitle }
    var header          : some View { data.header }
    var content         : some View { data.content }
    var imageName       : String { customImageName ?? data.imageName }
    var image           : SourceImage {
                            (data.icon.map { Image(nsImage: $0) } ??
                                Image(systemName: imageName))
                                    .with(style: data.imageStyle)
                        }
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
