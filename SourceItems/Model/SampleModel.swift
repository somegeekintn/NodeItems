//
//  SampleModel.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

class SampleModel: ObservableObject {
    typealias   SampleItem1 = ParentItem<StringSource, ChildlessItem<IntSource>>
    typealias   SampleItem2 = ParentItem<IntSource, ChildlessItem<StringSource>>
    
    var items1  : [SampleItem1]
    var items2  : [SampleItem2]
    
    init() {
        items1 = (0..<10).map {
            SampleItem1(
                data: StringSource(value: NumberFormatter.localizedString(from: $0 as NSNumber, number: .spellOut)),
                children: (0..<10).map { ChildlessItem(data: IntSource(value: $0)) }
            )
        }
        items2 = (0..<10).map {
            SampleItem2(
                data: IntSource(value: $0),
                children: (0..<10).map { ChildlessItem(data: StringSource(value: String($0))) }
            )
        }
    }
}
