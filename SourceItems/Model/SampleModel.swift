//
//  SampleModel.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

class SampleModel: ObservableObject {
    typealias   ChildlessInt            = SourceType<Int, Never>
    typealias   ChildlessString         = SourceType<String, Never>
    typealias   ParentIntChildString    = SourceType<Int, ChildlessString>
    typealias   ParentStringChildInt    = SourceType<String, ChildlessInt>
    
    var items1      : [ParentStringChildInt]
    var items2      : [ParentIntChildString]
    var items3      : [SourceType<SymbolSource, ParentStringChildInt>]

    @SourceBuilder var itemAlt1  : some SourceList {
        for symbol in ["eyes", "nose", "mouth", "figure.walk", "figure.stand", "figure.wave"] {
            SymbolSource(name: symbol).with {
                for val in 0..<10 {
                    val.with {
                        for str in 0..<10 {
                            NumberFormatter.localizedString(from: str as NSNumber, number: .spellOut)
                        }
                    }
                }
            }
        }
    }
    
    init() {
        items1 = (0..<10).map {
            SourceType(
                data: NumberFormatter.localizedString(from: $0 as NSNumber, number: .spellOut),
                children: (0..<10).map { SourceType(data: $0) }
            )
        }
        
        items2 = (0..<10).map {
            SourceType(
                data: $0,
                children: (0..<10).map { SourceType(data: String($0)) }
            )
        }

        items3 = ["eyes", "nose", "mouth", "figure.walk", "figure.stand", "figure.wave"].map {
            SourceType(
            data: SymbolSource(name: $0),
            children: (0..<10).map {
                SourceType(
                    data: NumberFormatter.localizedString(from: $0 as NSNumber, number: .spellOut),
                    children: (0..<10).map { SourceType(data: $0) })
            })
        }
        items3.append(SourceType(data: SymbolSource(name: "exclamationmark.octagon"), children: []))
    }
}
