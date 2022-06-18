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
            icon: { SourceItemImage(imageDesc: item.imageDesc) }
        )
    }
}

struct SourceItemLabel_Previews: PreviewProvider {
    static var sampleItems = SampleModel().sourceItemsA()[0...1]

    static var previews: some View {
        ForEach(sampleItems) { item in
            SourceItemLabel(item: item)
            SourceItemLabel(item: item)
        }
    }
}
