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

    var id              : UUID { get }
    var data            : Model { get }
    var children        : [Child]? { get set }

    @discardableResult func filtered(matching term: String) -> (fItem: Self, match: Bool)
}

extension SourceItem {
    var customImgDesc   : SourceImageDesc? { nil }

    var title           : String { data.title }
    var headerTitle     : String { data.headerTitle }
    var header          : some View { data.header }
    var content         : some View { data.content }
    var imageDesc       : SourceImageDesc { customImgDesc ?? data.imageDesc }

    // A little different. Return self with filtered children and
    // whether or not self or children contain a match.
    func filtered(matching term: String) -> (fItem: Self, match: Bool) {
        guard !term.isEmpty else { return (self, true) }
        var filteredItem    = self
        let match           = filteredItem.title.uppercased().contains(term.uppercased())
        var childMatch      = false

        if let srcChildren = self.children {
            let fChildren = srcChildren.compactMap { child -> Self.Child? in
                let filtered = child.filtered(matching: term)
                
                return filtered.match ? filtered.fItem : nil
            }
            
            filteredItem.children = fChildren
            childMatch = !fChildren.isEmpty
        }
        
        return (filteredItem, match || childMatch)
    }
}

struct SourceItemVal<Model: SourceItemData, Child: SourceItem>: SourceItem {
    var id          = UUID()
    var data        : Model
    var children    : [Child]?
}

extension Never: SourceItem {
    public var id       : UUID   { fatalError() }
    public var data     : Never    { fatalError() }
    public var children : [Never]? { get { fatalError() } set { } }
}
