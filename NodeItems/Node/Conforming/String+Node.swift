//
//  String+Node.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/2/23.
//

import SwiftUI

extension String: Node {
    var titleLabel  : String { "String: \(self)" }
    
    var label: some View {
        Label(titleLabel, systemImage: "list.bullet.circle")
    }
    
    var content: some View {
        Text(titleLabel)
    }
    
    func matchesFilterTerm(_ term: String) -> Bool {
        titleLabel.contains(term)
    }
}
