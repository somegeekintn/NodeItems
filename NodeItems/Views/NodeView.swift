//
//  NodeView.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/2/23.
//

import SwiftUI

struct NodeView<T: Node>: View {
    var node            : T
    
    init(_ node: T) {
        self.node = node
    }
    
    init<Item: Node>(@NodeListBuilder items: () -> [Item]) where T == RootNode<Item> {
        self.node = RootNode(items)
    }

    var body: some View {
        List {
            if let items = node.items {
                ForEach(items.indices, id: \.self) { index in
                    Item(node: items[index])
                }
            }
            else {
                Text("No Items")
            }
        }
    }
}

extension NodeView {
    struct ItemList<T: NodeList>: View {
        var items   : T
        
        init(items: T) {
            self.items = items
        }
        
        var body: some View {
            ForEach(items.indices, id: \.self) { index in
                NodeView.Item(node: items[index])
            }
        }
    }

    struct Item<T: Node>: View {
        @State var expanded         = false
        
        var node    : T
        
        var body: some View {
            NodeLabel(node, expanded: $expanded) { _ in // deep expansion unsupported
                expanded.toggle()
            }
            
            if let items = node.items, expanded {
                NodeView.ItemList(items: items)
                    .padding(.leading, 12.0)
            }
        }
    }
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NodeView {
                1
                (2...4).map { $0 }
                ("hello") {
                    42
                }
            }
        }
    }
}
