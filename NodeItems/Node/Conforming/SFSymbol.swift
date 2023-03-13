//
//  SFSymbol.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/2/23.
//

import SwiftUI

struct SFSymbol: Node {
    let name        : String
    var title       : String { "SF Symbol: \(name)" }

    var icon        : some View { Image(systemName: name) }

    var content: some View {
        VStack {
            Text(title)
            icon
        }
    }
}
