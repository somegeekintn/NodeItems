//
//  Int+Node.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/2/23.
//

import SwiftUI

extension Int: Node {
    var titleLabel  : String { "Int: \(self)" }

    var label: some View {
        Label(titleLabel, systemImage: "number.circle")
    }
    
    var content: some View {
        Text(titleLabel)
    }
    
    func matchesFilterTerm(_ term: String) -> Bool {
        titleLabel.contains(term)
    }
}
