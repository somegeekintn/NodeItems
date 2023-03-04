//
//  NodeLabel.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/3/23.
//

import SwiftUI

struct NodeLabel<T: Node>: View {
    @Binding var expanded:  Bool
    
    let node    : T
    
    init(_ node: T, expanded: Binding<Bool>) {
        self.node = node
        self._expanded = expanded
    }
    
    var body: some View {
        HStack(spacing: 0) {
            let button =
                Button(
                    action: {
                        withAnimation(.easeInOut(duration: 0.2)) { expanded.toggle() }
                    },
                    label: {
                        Image(systemName: "chevron.right")
                            .padding(.horizontal, 4.0)
                            .contentShape(Rectangle())
                            .rotationEffect(.degrees(expanded ? 90.0 : 0.0))
                    }
                )
                .buttonStyle(.plain)
            
            if node.items != nil { button }
            else { button.hidden() }
            
            NavigationLink(destination: node.content, label: { node.label })
        }
    }
}


struct NodeLabel_Previews: PreviewProvider {
    static var previews: some View {
        NodeLabel(NodeConnector("Base") {
            1
            2
            3
        }, expanded: Binding.constant(false))
    }
}
