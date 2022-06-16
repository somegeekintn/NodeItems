//
//  SourceItemGroup.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

struct SourceItemGroup<Item: SourceItem>: View {
    @State private var isExpanded   = false

    var item   : Item

    var body: some View {
        if let childItems = item.children, childItems.count > 0 {
            DisclosureGroup(
                isExpanded: $isExpanded) {
                    ForEach(childItems) { childItem in
                        SourceItemGroup<Item.Child>(item: childItem)
                    }
                } label: {
                    SourceItemLink(item: item)
                }
        }
        else {
            SourceItemLink(item: item)
        }
    }
}

struct SourceItemGroup_Previews: PreviewProvider {
    static var sampleItem = SampleModel().items1[0]

    static var previews: some View {
        SourceItemGroup(item: sampleItem)
    }
}
