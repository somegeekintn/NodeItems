//
//  SampleModel.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

enum OneOf<A, B, C, D>: Identifiable {
    case a(id: UUID = UUID(), A)
    case b(id: UUID = UUID(), B)
    case c(id: UUID = UUID(), C)
    case d(id: UUID = UUID(), D)
    
    var id      :  UUID {
        switch self {
            case let .a(id, _):     return id
            case let .b(id, _):     return id
            case let .c(id, _):     return id
            case let .d(id, _):     return id
        }
    }
}

// Named SampleModel and contains model but also aspects of presentation
// This would be broken out in a "real world" situation

class SampleModel: ObservableObject {
    typealias   IntItem             = SourceItemVal<Int, Never>
    typealias   StringItem          = SourceItemVal<String, Never>
    typealias   IntString           = SourceItemVal<Int, StringItem>
    typealias   StringInt           = SourceItemVal<String, IntItem>
    typealias   SymbolStringInt     = SourceItemVal<SymbolSource, StringInt>
    typealias   MultiRoot           = OneOf<
                                        String,
                                        SourceRoot<SymbolStringInt>,
                                        SourceRoot<IntString>,
                                        SourceRoot<StringInt>>

    enum Variant: Int, CaseIterable, Identifiable {
        case v0
        case v1
        case v2
        case v3
        
        var id      : Int { rawValue }
        var title   : String {
            switch self {
                case .v0: return "Placeholder"
                case .v1: return "Symbol / String / Int"
                case .v2: return "Int / String"
                case .v3: return "String / Int"
            }
        }
    }
    
    @Published var variant      = Variant.v0 { didSet { multiRoot = rootFor(variant: variant) } }
    @Published var filter       = ""

    // Note: sometimes filtering clears the selection and sometimes not. Sometimes
    // the selection remains even if the items has been filtered out. <thinking face>
    @Published var selection    : UUID? {
        didSet {
            if let sel = selection { print("New \(sel.uuidString)") }
            else { print("No selection") }
        }
    }
    
    // Added placeholder variant because we don't want multiRoot to be a computed value
    // Instead we want the filtered items to be the identified the same as the unfiltered
    // ones.
    var multiRoot           : MultiRoot = MultiRoot.a("Placeholder")
    var filteredRoot        : MultiRoot {
        switch multiRoot {
            case .a:                return multiRoot
            case let .b(_, root):   return .b(id: multiRoot.id, root.filtered(matching: filter))
            case let .c(_, root):   return .c(id: multiRoot.id, root.filtered(matching: filter))
            case let .d(_, root):   return .d(id: multiRoot.id, root.filtered(matching: filter))
        }
    }
    
    init() {
        variant = Variant.v1
    }
    
    func rootFor(variant: Variant) -> MultiRoot {
        switch variant {
            case .v0:   return .a("Placeholder")
            case .v1:   return .b(SourceRoot(items: sourceItemsA()))
            case .v2:   return .c(SourceRoot(items: sourceItemsB()))
            case .v3:   return .d(SourceRoot(items: sourceItemsC()))
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
