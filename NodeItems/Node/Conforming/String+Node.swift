//
//  String+Node.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/2/23.
//

import SwiftUI

extension String: Node {
    var title       : String { "Int: \(self)" }

    var icon        : some View { Image(systemName: "list.bullet.circle") }
    var content     : some View { Text(title) }
}
