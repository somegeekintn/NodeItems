//
//  FilteredNodeView.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/3/23.
//

import SwiftUI

struct FilteredNodeView<T: Node>: View {
    @StateObject var node   : FilteredNode<T>
    @State var filter       : String = ""
    
    init(_ node: T) {
        self._node = StateObject(wrappedValue: FilteredNode(node))
    }
    
    init<Item: Node>(@NodeListBuilder items: () -> [Item]) where T == RootNode<Item> {
        self.init(RootNode(items))
    }

    var body: some View {
        Root(node: node)
            .searchable(text: $filter, placement: .sidebar)
            .onChange(of: filter) { term in
                node.applyFilter(term)
            }
    }
}

extension FilteredNodeView {
    struct Root: View {
        @ObservedObject var node    : FilteredNode<T>
        
        var visibleItems    : FilteredNode<T>.Children { node.items.map { $0.filter { !$0.filtered} } ?? [] }

        var body: some View {
            let items = visibleItems
            
            List {
                if !items.isEmpty {
                    ForEach(items.indices, id: \.self) { index in
                        FilteredNodeView.Item(node: items[index])
                    }
                }
                else {
                    Text("No Filter Results")
                }
            }
        }
    }

    struct ItemList<T: Node>: View {
        var items   : [FilteredNode<T>]
        
        init(items: [FilteredNode<T>]) {
            self.items = items
        }
        
        var body: some View {
            ForEach(items.indices, id: \.self) { index in
                FilteredNodeView.Item(node: items[index])
            }
        }
    }

    struct Item<T: Node>: View {
        @ObservedObject var node    : FilteredNode<T>
        
        var body: some View {
            if !node.filtered {
                NodeLabel(node, expanded: $node.isExpanded) { deep in
                    node.toggleExpanded(deep: deep)
                }
                
                if let items = node.items, node.isExpanded {
                    FilteredNodeView.ItemList(items: items)
                        .padding(.leading, 12.0)
                }
            }
        }
    }
}

struct FilteredNodeView_Previews: PreviewProvider {
    @State static var filter    = ""
    
    static var previews: some View {
        List {
            FilteredNodeView() {
                1
                (2...4).map { $0 }
                ("hello") {
                    42
                }
            }
        }
    }
}
