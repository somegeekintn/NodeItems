//
//  SourceItemLabel.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

struct SourceItemLabel<Item: SourceItem>: View {
    var item   : Item

    var body: some View {
        Label(
            title: { Text(item.title) },
            icon: { SourceItemImage(styledImage: item.image) }
        )
    }
}

struct SourceItemLabel_Previews: PreviewProvider {
    static var sampleItem1 = SampleModel().items1[0]
    static var sampleItem2 = SampleModel().items2[0]

    static var previews: some View {
        SourceItemLabel(item: sampleItem1)
        SourceItemLabel(item: sampleItem2)
    }
}
