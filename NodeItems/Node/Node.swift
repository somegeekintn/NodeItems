//
//  Node.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/2/23.
//

import SwiftUI

/// A type providing a label and content suitable for use in a sidebar / detail
/// navigation configuration. In addition a `Node` may optionally provide
/// chilld items when the sidebar presents a heirarchy of items.

protocol Node: NodeSource {
    associatedtype Icon: View
    associatedtype Content: View

    var title       : String { get }

    @ViewBuilder var icon : Icon { get }
    @ViewBuilder var content : Content { get }

    func matchesFilterTerm(_ term: String) -> Bool
}

extension Node {
    var items       : [LeafNode]? { nil }

    func callAsFunction<Item: Node>(@NodeListBuilder items: () -> [Item]) -> NodeLink<Self, Item> {
        NodeLink(self, items: items)
    }

    func matchesFilterTerm(_ term: String) -> Bool {
        term.isEmpty || title.uppercased().contains(term.uppercased())
    }
}

/// Indicates a type that owns a list of child Nodes

protocol NodeSource {
    associatedtype Children: NodeList

    var items    : Children? { get }
}

/// Defines the requirements of a collection that can be considered a `NodeList`.

protocol NodeList: RandomAccessCollection where Element: Node, Index: Hashable { }
extension Array: NodeList where Element: Node { }

// MARK: - Special Nodes -

/// Not a real Node itself, as it cannot be constructed, but an indication that the parent is a leaf.

enum LeafNode: Node {
    var title       : String { "impossible" }

    var icon        : some View { Image(systemName: "questionmark.circle") }
    var content     : some View { Text("impossible") }
}

struct RootNode<Item: Node>: Node {
    var items       : [Item]?
    var title       : String { "Root" }

    var icon        : some View { Image(systemName: "tree") }
    var content     : some View { Text("Root") }

    init() {
        self.items = nil
    }

    init(@NodeListBuilder _ items: () -> [Item]) {
        self.items = items()
    }
}

struct NodeLink<Base: Node, Item: Node>: Node {
    var base        : Base
    var items       : [Item]?

    var title       : String { base.title }
    var icon        : Base.Icon { base.icon }
    var content     : Base.Content { base.content }

    init(_ base: Base, @NodeListBuilder items: () -> [Item]) {
        self.base = base
        self.items = items()
    }
}
