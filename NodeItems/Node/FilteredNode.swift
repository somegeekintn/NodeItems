//
//  FilteredNode.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/3/23.
//

import SwiftUI
import Combine

class FilteredNode<T: Node>: Node, ObservableObject {
    typealias FilteredList = [FilteredNode<T.List.Element>]
    
    @Published var filtered : Bool

    var wrappedNode : T
    var label       : some View { wrappedNode.label }
    var content     : some View { wrappedNode.content }
    var items       : FilteredList?
    
    init(_ node: T) {
        self.wrappedNode = node
        self.filtered = false
        
        self.items = node.items?.asFilteredNodes()
    }
    
    func matchesFilterTerm(_ term: String) -> Bool {
        wrappedNode.matchesFilterTerm(term)
    }
    
    @discardableResult
    func applyFilter(_ term: String) -> Bool {
        let itemMatch = items?.reduce(false) { result, node in
            node.applyFilter(term) || result    // deliberately not short circuiting here
        } ?? false
        let nodeMatch = term.isEmpty || itemMatch || wrappedNode.matchesFilterTerm(term)
        
        filtered = !nodeMatch
        
        return nodeMatch
    }
}

extension NodeList {
    func asFilteredNodes() -> [FilteredNode<Element>] {
        self.map { FilteredNode($0) }
    }
}

