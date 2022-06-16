//
//  IntHeader.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

extension Int {
    public var header  : some View { IntHeader(value: self) }
}

struct IntHeader: View {
    var value  : Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3.0) {
            Text("Header for IntSource")
            Text(value.title)
        }
        .font(.subheadline)
    }
}

struct IntHeader_Previews: PreviewProvider {
    static var previews: some View {
        IntHeader(value: 27)
            .preferredColorScheme(.dark)
        IntHeader(value: 42)
            .preferredColorScheme(.light)
    }
}
