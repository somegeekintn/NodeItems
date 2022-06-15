//
//  IntHeader.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

extension IntSource {
    var header  : some View { IntHeader(source: self) }
}

struct IntHeader: View {
    var source  : IntSource
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3.0) {
            Text("Header for IntSource")
            Text(source.title)
        }
        .font(.subheadline)
    }
}

struct IntHeader_Previews: PreviewProvider {
    static var previews: some View {
        IntHeader(source: IntSource(value: 27))
            .preferredColorScheme(.dark)
        IntHeader(source: IntSource(value: 42))
            .preferredColorScheme(.light)
    }
}
