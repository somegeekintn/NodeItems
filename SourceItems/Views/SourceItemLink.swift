//
//  SourceItemLink.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

struct SourceItemLink<Item: SourceItem>: View {
    var item   : Item

    var body: some View {
        NavigationLink(
            destination: { SourceItemContent(item: item) },
            label: {
                SourceItemLabel(item: item)
                    .padding(.leading, 2.0)
            }
        )
    }
}

struct SourceItemLink_Previews: PreviewProvider {
    static var sampleItem = SampleModel().sourceItemsA()[0]

    static var previews: some View {
        SourceItemLink(item: sampleItem)
            .preferredColorScheme(.dark)
        SourceItemLink(item: sampleItem)
            .preferredColorScheme(.light)
    }
}
