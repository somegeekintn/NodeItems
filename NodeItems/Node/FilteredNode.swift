//
//  FilteredNode.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/3/23.
//

import SwiftUI
import Combine

class FilteredNode<T: Node>: Node, ObservableObject {
    typealias FilteredList = [FilteredNode<T.Children.Element>]
    
    @Published var filtered : Bool
    @Published var isExpanded = false

    var wrappedNode : T
    var title       : String { wrappedNode.title }
    var icon        : some View { wrappedNode.icon }
    var content     : some View { wrappedNode.content }
    var items       : FilteredList?
    var children    : FilteredList { items ?? [] }
    
    init(_ node: T) {
        self.wrappedNode = node
        self.filtered = false
        
        self.items = node.items?.asFilteredNodes()
    }
    
    func toggleExpanded(_ expanded: Bool? = nil, deep: Bool) {
        isExpanded = expanded ?? !isExpanded
        
        if deep {
            for child in children {
                child.toggleExpanded(isExpanded, deep: true)
            }
        }
    }

    @discardableResult
    func applyFilter(_ term: String) -> Bool {
        let itemMatch = children.reduce(false) { result, node in
            node.applyFilter(term) || result    // deliberately not short circuiting here
        }
        let nodeMatch = term.isEmpty || itemMatch || matchesFilterTerm(term)
        
        filtered = !nodeMatch
        
        return nodeMatch
    }
}

extension NodeList {
    func asFilteredNodes() -> [FilteredNode<Element>] {
        self.map { FilteredNode($0) }
    }
}
