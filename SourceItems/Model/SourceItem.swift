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

    var data        : Model { get }
    var children    : [Child]? { get }
    var customID    : String? { get }
}

extension SourceItem {
    var customID        : String? { nil }
    var customImageName : String? { nil }

    var id              : String { customID ?? data.id }
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

struct ParentItem<Model: SourceItemData, ChildItem: SourceItem>: SourceItem {
    var data        : Model
    var children    : [ChildItem]?
}

struct ChildlessItem<Model: SourceItemData>: SourceItem {
    var data        : Model
    var children    : [Never]? = nil
}

extension Never: SourceItem {
    var data        : Never    { fatalError() }
    var children    : [Never]? { fatalError() }
}

