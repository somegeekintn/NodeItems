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
    typealias   IntItem             = SourceItemVal<Int, SourceItemNone>
    typealias   StringItem          = SourceItemVal<String, SourceItemNone>
    typealias   IntString           = SourceItemVal<Int, StringItem>
    typealias   StringInt           = SourceItemVal<String, IntItem>
    typealias   SymbolStringInt     = SourceItemVal<SymbolSource, StringInt>
    typealias   MultiRoot           = OneOf<
                                        String,
                                        SourceItemVal<SourceItemDataNone, SymbolStringInt>,
                                        SourceItemVal<SourceItemDataNone, IntString>,
                                        SourceItemVal<SourceItemDataNone, StringInt>>

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
    
    @Published var variant      = Variant.v0 { didSet { rebuildBase() } }
    @Published var filter       = "" { didSet { applyFilter() } }

    // Note: sometimes filtering clears the selection and sometimes not. Sometimes
    // the selection remains even if the items has been filtered out. <thinking face>
    @Published var selection    : UUID? {
        didSet {
            if let sel = selection { print("New \(sel.uuidString)") }
            else { print("No selection") }
        }
    }
    
    var base            : MultiRoot = MultiRoot.a("Placeholder")
    
    init() {
        variant = Variant.v1
        
        self.rebuildBase()
    }
    
    func applyFilter() {
        switch base {
            case .a:                break
            case let .b(_, item):   item.applyFilter(matching: filter)
            case let .c(_, item):   item.applyFilter(matching: filter)
            case let .d(_, item):   item.applyFilter(matching: filter)
        }
    }
    
    func rebuildBase() {
        var baseID  : UUID
        
        // Preserve identifier if style is not changing
        switch (variant, base) {
            case (.v0, let .a(id, _)):  baseID = id;
            case (.v1, let .b(id, _)):  baseID = id;
            case (.v2, let .c(id, _)):  baseID = id;
            case (.v3, let .d(id, _)):  baseID = id;
            default:                    baseID = UUID()
        }
        
        switch variant {
            case .v0:   base = .a(id: baseID, "Placeholder")
            case .v1:   base = .b(id: baseID, SourceItemVal(data: .none, children: sourceItemsA()))
            case .v2:   base = .c(id: baseID, SourceItemVal(data: .none, children: sourceItemsB()))
            case .v3:   base = .d(id: baseID, SourceItemVal(data: .none, children: sourceItemsC()))
        }
        
        applyFilter()
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
