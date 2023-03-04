//
//  SampleModel.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/2/23.
//

import Foundation
import Combine

class SampleModel: ObservableObject {
    enum Variant: Int, CaseIterable {
        case v0
        case v1
        case v2
        case v3
        
        static var selectable   : [Variant] { Array(allCases.dropFirst()) }

        var title   : String {
            switch self {
                case .v0: return "Placeholder"
                case .v1: return "Symbol / String / Int"
                case .v2: return "Int / String"
                case .v3: return "String / Int"
            }
        }
    }

    @Published var variant  = Variant.v0
    
    @NodeListBuilder
    var items : some NodeList {
        switch variant {
            case .v0, .v1:  itemsA.asFilteredNodes()
            case .v2:       itemsB.asFilteredNodes()
            case .v3:       itemsC.asFilteredNodes()
        }
    }

    @NodeListBuilder
    var itemsA : some NodeList {
        ["eyes", "nose", "mouth", "figure.walk", "figure.stand", "figure.wave"].map { value in
            SFSymbol(name: value) {
                itemsC
            }
        }
    }

    @NodeListBuilder
    var itemsB : some NodeList {
        (0..<10).map { value in
            value {
                (0..<10).map { NumberFormatter.localizedString(from: $0 as NSNumber, number: .spellOut) }
            }
        }
    }
    
    @NodeListBuilder
    var itemsC : some NodeList {
        (0..<10).map { value in
            (NumberFormatter.localizedString(from: value as NSNumber, number: .spellOut)) {
                (0..<10).map { $0 }
            }
        }
    }
}

