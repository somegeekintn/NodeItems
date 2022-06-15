//
//  IntContent.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

extension IntSource {
    var content : some View { IntContent(source: self) }
}

struct IntContent: View {
    var source  : IntSource

    var body: some View {
        VStack(alignment: .leading) {
            Text("Value: \(source.value)")
                .font(.headline)
            Divider()
            Text("Int Overview")
                .font(.largeTitle)
                .fontWeight(.light)
                .padding(.bottom)
            Text("On 32-bit platforms, Int is the same size as Int32, and on 64-bit platforms, Int is the same size as Int64.")
        }
    }
}

struct IntContent_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView { IntContent(source: IntSource(value: 27)) }
            .preferredColorScheme(.dark)
        ScrollView { IntContent(source: IntSource(value: 42)) }
            .preferredColorScheme(.light)
    }
}
