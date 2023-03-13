//
//  NodeLabel.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/3/23.
//

import SwiftUI

struct NodeLabel<T: Node>: View {
    @Binding var isExpanded     : Bool
 
    let node            : T
    let toggleExpanded  : (_ deep: Bool) -> ()
    
    init(_ node: T, expanded: Binding<Bool>, expandedToggle: @escaping (Bool) -> ()) {
        self.node = node
        self._isExpanded = expanded
        self.toggleExpanded = expandedToggle
    }
    
    var body: some View {
        HStack(spacing: 0) {
            let button =
                Button(
                    action: {
                        let optionActive = NSApplication.shared.currentEvent?.modifierFlags.contains(.option) == true
                        
                        withAnimation(.easeInOut(duration: 0.2)) {
                            toggleExpanded(optionActive)
                        }
                    },
                    label: {
                        Image(systemName: "chevron.right")
                            .padding(.horizontal, 4.0)
                            .contentShape(Rectangle())
                            .rotationEffect(.degrees(isExpanded ? 90.0 : 0.0))
                    }
                )
                .buttonStyle(.plain)
            
            if node.items != nil { button }
            else { button.hidden() }
            
            NavigationLink(
                destination: { node.content },
                label: {
                    Label(
                        title: { Text(node.title) },
                        icon: { node.icon }
                    )
                }
            )
        }
    }
}

struct NodeLabel_Previews: PreviewProvider {
    static var previews: some View {
        NodeLabel(RootNode {
            1
            2
            3
        }, expanded: Binding.constant(true)) { _ in }
    }
}
