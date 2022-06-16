//
//  StringHeader.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

extension String {
    var header  : some View { StringHeader(value: self) }
}

struct StringHeader: View {
    var value  : String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3.0) {
            Text("Header for StringSource")
            Text(value.title)
        }
        .font(.subheadline)
    }
}

struct StringHeader_Previews: PreviewProvider {
    static var previews: some View {
        StringHeader(value: "hello")
            .preferredColorScheme(.dark)
        StringHeader(value: "world")
            .preferredColorScheme(.light)
    }
}
