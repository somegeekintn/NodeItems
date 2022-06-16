//
//  SourceItem.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/14/22.
//

import SwiftUI

protocol SourceItem: Identifiable {
    associatedtype Model    : SourceItemData
    associatedtype Child    : SourceItem

    var id              : String { get }
    var data            : Model { get }
    var children        : [Child]? { get }
}

extension SourceItem {
    var customImageName : String? { nil }

    var title           : String { data.title }
    var headerTitle     : String { data.headerTitle }
    var header          : some View { data.header }
    var content         : some View { data.content }
    var imageName       : String { customImageName ?? data.imageName }
    var image           : SourceImage {
                            (data.icon.map { Image(nsImage: $0) } ??
                                Image(systemName: imageName))
                                    .with(style: data.imageStyle)
                        }
}

struct SourceType<Model: SourceItemData, Child: SourceItem>: SourceItem {
    var id          = UUID().uuidString
    var data        : Model
    var children    : [Child]?
}

protocol SourceList {
    associatedtype Item    : SourceItem

    var items       : [Item] { get }
}

struct SourceContainer<Item: SourceItem> : SourceList {
    let items       : [Item]
}

extension Never: SourceItem {
    public var id       : String   { "ERROR" }
    public var data     : Never    { fatalError() }
    public var children : [Never]? { fatalError() }
}

@resultBuilder
struct SourceBuilder {
    static func buildBlock<Item: SourceItem>(_ items: [Item]...) -> [Item] {
        Array(items.joined())
    }

    static func buildBlock<ItemA: SourceItem, ItemB>(_ itemA: [ItemA], _ itemB: [ItemB]) -> [ItemA] {
        []
    }

    static func buildExpression<Data: SourceItemData>(_ data: Data) -> [SourceType<Data, Never>] {
        [SourceType<Data, Never>(data: data)]
    }

    static func buildExpression<Item: SourceItem>(_ item: Item) -> [Item] {
        [item]
    }

    // (SourceItemData, [SourceItem]) from SourceItemData.with()
    static func buildExpression<Data: SourceItemData, Item: SourceItem>(_ pair: (data: Data, items: [Item])) -> [SourceType<Data, Item>] {
        [SourceType<Data, Item>(data: pair.data, children: pair.items)]
    }

    // [(SourceItemData, [SourceItem])] from single level of map onto SourceItemData.with() 
    static func buildExpression<Data: SourceItemData, Item: SourceItem>(_ pairs: [(data: Data, items: [Item])]) -> [SourceType<Data, Item>] {
        return pairs.map { (data, items) in
            SourceType<Data, Item>(data: data, children: items)
        }
    }

    // Single SourceContainer
    static func buildExpression<Item: SourceItem>(_ container: SourceContainer<Item>) -> [Item] {
        container.items
    }

    static func buildArray<Item: SourceItem>(_ components: [[Item]]) -> [Item] {
        return components.flatMap { $0 }
    }
    
    static func buildFinalResult<Item: SourceItem>(_ items: [Item]) -> SourceContainer<Item> {
        return SourceContainer<Item>(items: items)
    }
}

struct TestBuilder {
    init() {
        testBuild("Loop") {
            for x in 0...10 {
                x.with {
                    for y in 0...10 {
                        y
                    }
                }
            }
        }

        testBuild("Single Childless") {
            3
        }

        testBuild("Mixed Child Items") {
            // Currently matching buildBlock<ItemA, ItemB> and returning nothing
            // what we'd like to do is promote the first item to a kind with an
            // empty array of children. How to match and how to test since this
            // could be any number in any order? Furthermore, the return type
            // signature cannot be variable.
            
            // We could have something like withEmpty to indicate this item is capable
            // of having children, but does not currently have them.
            
            // Finally how will all of this work once filtering is added in? I guess
            // the type will not have to change and we can just empty the arrays as
            // needed and no disclosure would be shown
            3
            3.with {
                "foo"
            }
        }
    }
    
    func testBuild<Item: SourceItem>(_ msg: String, @SourceBuilder children: () -> SourceContainer<Item>) {
        print("\(msg): \(children().items)")
    }
}

