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
    associatedtype Tag: View
    associatedtype Content: View
    
    @ViewBuilder var label   : Tag { get }
    @ViewBuilder var content : Content { get }

    func matchesFilterTerm(_ term: String) -> Bool
}

extension Node {
    var items       : [LeafNode]? {
        get { nil }
        set { }
     }

    func callAsFunction<Item: Node>(@NodeListBuilder items: () -> [Item]) -> NodeConnector<Self, Item> {
        NodeConnector(self, items: items)
    }
//    
//    // Check me
//    mutating
//    func callAsFunction<Item: Node>(@NodeListBuilder items: () -> [Item]) -> Self where Self.List == Array<Item> {
//        self.items = items()
//        
//        return self
//    }
    func matchesFilterTerm(_ term: String) -> Bool {
        return false
    }
}

/// Indicates a type that owns a list of Nodes

protocol NodeSource {
    associatedtype List: NodeList

    var items    : List? { get set }
}

/// Defines the requirements of a collection that can serve as a `NodeList`.

protocol NodeList: RandomAccessCollection where Element: Node, Index: Hashable { }
extension Array: NodeList where Element: Node { }

// MARK: - Special Nodes -

enum LeafNode: Node {
    var label: some View { Text("impossible") }
    var content: some View { Text("impossible") }
}

struct RootNode<Item: Node>: Node {
    var items       : [Item]?
    var label       : some View { Label("Root", systemImage: "tree") }
    var content     : some View { Text("Root") }

    init() {
        self.items = nil
    }
    
    init(@NodeListBuilder _ items: () -> [Item]) {
        self.items = items()
    }
}

struct NodeConnector<Base: Node, Item: Node>: Node {
    var base        : Base
    var items       : [Item]?
    var label       : Base.Tag { return base.label }
    var content     : Base.Content { return base.content }
    
    init(_ base: Base, @NodeListBuilder items: () -> [Item]) {
        self.base = base
        self.items = items()
    }

@available(*, deprecated, message: "Consider using Root { items } instead")
    init(@NodeListBuilder _ items: () -> [Item]) where Base == RootNode<Item> {
        self.base = RootNode()
        self.items = items()
    }
    
    func matchesFilterTerm(_ term: String) -> Bool {
        base.matchesFilterTerm(term)
    }
}
