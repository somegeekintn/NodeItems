//
//  SFSymbol.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/2/23.
//

import SwiftUI

struct SFSymbol: Node {
    let name        : String
    var titleLabel  : String { "SF Symbol: \(name)" }

    var label: some View {
        Label(titleLabel, systemImage: name)
    }
    
    var content: some View {
        VStack {
            Text(titleLabel)
            Image(systemName: name)
        }
    }
    
    func matchesFilterTerm(_ term: String) -> Bool {
        titleLabel.contains(term)
    }
}
