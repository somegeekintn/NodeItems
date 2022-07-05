//
//  SourceItem.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/14/22.
//

import SwiftUI

protocol SourceItem: Identifiable, ObservableObject {
    associatedtype Model    : SourceItemData
    associatedtype Child    : SourceItem

    var id              : UUID { get }
    var data            : Model { get }
    var children        : [Child] { get set }
    var visibleChildren : [Child] { get set }
    var customImgDesc   : SourceImageDesc? { get }
}

extension SourceItem {
    var title           : String { data.title }
    var headerTitle     : String { data.headerTitle }
    var header          : some View { data.header }
    var content         : some View { data.content }
    var imageDesc       : SourceImageDesc { customImgDesc ?? data.imageDesc }
    var customImgDesc   : SourceImageDesc? { nil }

    func applyFilter(matching term: String) {
        visibleChildren = children.filter { $0.applyingFilter(matching: term) }
    }

    func applyingFilter(matching term: String) -> Bool {
        var match           = true

        if !term.isEmpty && match {
            match = title.uppercased().contains(term.uppercased())
        }

        visibleChildren = children.filter { $0.applyingFilter(matching: term) }

        return match || !visibleChildren.isEmpty
    }
}

class SourceItemVal<Model: SourceItemData, Child: SourceItem>: SourceItem {
    @Published var visibleChildren  : [Child]
    
    var id              = UUID()
    var data            : Model
    var children        : [Child]
    var customImgDesc   : SourceImageDesc?
    
    init(id: UUID = UUID(), data: Model, children: [Child] = [], customImgDesc: SourceImageDesc? = nil) {
        self.id = id
        self.data = data
        self.children = children
        self.visibleChildren = children
        self.customImgDesc = customImgDesc
    }
}

class SourceItemNone: SourceItem {
    var id              = UUID()
    var data            = SourceItemDataNone()
    var children        = [SourceItemNone]()
    var visibleChildren = [SourceItemNone]()
}
