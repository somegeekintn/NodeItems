//
//  SourceItemLink.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

struct SourceItemLink<Item: SourceItem>: View {
    @Binding var selection: UUID?

    var item   : Item

    var body: some View {
        NavigationLink(tag: item.id, selection: $selection,
            destination: { SourceItemContent(item: item) },
            label: {
                SourceItemLabel(item: item)
                    .padding(.leading, 2.0)
            }
        )
    }
}

struct SourceItemLink_Previews: PreviewProvider {
    @State static var selection : UUID?
    static var sampleItem = SampleModel().sourceItemsA()[0]

    static var previews: some View {
        SourceItemLink(selection: $selection, item: sampleItem)
            .preferredColorScheme(.dark)
        SourceItemLink(selection: $selection, item: sampleItem)
            .preferredColorScheme(.light)
    }
}
