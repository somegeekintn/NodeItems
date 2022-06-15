//
//  StringHeader.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

extension StringSource {
    var header  : some View { StringHeader(source: self) }
}

struct StringHeader: View {
    var source  : StringSource
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3.0) {
            Text("Header for StringSource")
            Text(source.title)
        }
        .font(.subheadline)
    }
}

struct StringHeader_Previews: PreviewProvider {
    static var previews: some View {
        StringHeader(source: StringSource(value: "hello"))
            .preferredColorScheme(.dark)
        StringHeader(source: StringSource(value: "world"))
            .preferredColorScheme(.light)
    }
}
