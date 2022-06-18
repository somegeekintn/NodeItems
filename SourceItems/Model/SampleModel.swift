//
//  SampleModel.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

enum OneOf<A, B, C>: Identifiable {
    case a(id: String = UUID().uuidString, A)
    case b(id: String = UUID().uuidString, B)
    case c(id: String = UUID().uuidString, C)
    
    var id      :  String {
        switch self {
            case let .a(id, _):     return id
            case let .b(id, _):     return id
            case let .c(id, _):     return id
        }
    }
}

class SampleModel: ObservableObject {
    typealias   IntItem             = SourceItemVal<Int, Never>
    typealias   StringItem          = SourceItemVal<String, Never>
    typealias   IntString           = SourceItemVal<Int, StringItem>
    typealias   StringInt           = SourceItemVal<String, IntItem>
    typealias   SymbolStringInt     = SourceItemVal<SymbolSource, StringInt>
    typealias   MultiRoot           = OneOf<
                                        SourceRoot<SymbolStringInt>,
                                        SourceRoot<IntString>,
                                        SourceRoot<StringInt>>

    enum Variant: Int, CaseIterable, Identifiable {
        case v1
        case v2
        case v3
        
        var id      : Int { rawValue }
        var title   : String {
            switch self {
                case .v1: return "Symbol / String / Int"
                case .v2: return "Int / String"
                case .v3: return "String / Int"
            }
        }
    }
    
    @Published var variant  = Variant.v1

    var multiRoot           : MultiRoot { rootFor(variant: variant) }
    
    func rootFor(variant: Variant) -> MultiRoot {
        switch variant {
            case .v1:   return .a(SourceRoot(items: sourceItemsA()))
            case .v2:   return .b(SourceRoot(items: sourceItemsB()))
            case .v3:   return .c(SourceRoot(items: sourceItemsC()))
        }
    }
    
    func sourceItemsA() -> [SymbolStringInt] {
        ["eyes", "nose", "mouth", "figure.walk", "figure.stand", "figure.wave"].map {
            SymbolStringInt(
                data: SymbolSource(name: $0),
                children: (0..<10).map {
                    StringInt(
                        data: NumberFormatter.localizedString(from: $0 as NSNumber, number: .spellOut),
                        children: (0..<10).map { SourceItemVal(data: $0) }
                    )
                }
            )
        }
    }
    
    func sourceItemsB() -> [IntString] {
        (0..<10).map {
            IntString(
                data: $0,
                children: (0..<10).map { SourceItemVal(data: String($0)) }
            )
        }
    }
    
    func sourceItemsC() -> [StringInt] {
        (0..<10).map {
            StringInt(
                data: NumberFormatter.localizedString(from: $0 as NSNumber, number: .spellOut),
                children: (0..<10).map { SourceItemVal(data: $0) }
            )
        }
    }
    
#if false // not quite
    @SourceBuilder var moreItems : some SourceList {
        switch variant {
            case .v1:
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
                
            case .v2:
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
                
            case .v3:
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
    }
#endif
}
