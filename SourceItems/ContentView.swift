//
//  ContentView.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/14/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model   : SampleModel
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    Menu {
                        Picker("Variant", selection: $model.variant) {
                            ForEach(SampleModel.Variant.allCases) { variant in
                                Text(variant.title).tag(variant)
                            }
                        }
                        .pickerStyle(.inline)
                    } label: {
                        Label("Variant", systemImage: "slider.horizontal.3")
                    }

                    switch model.multiRoot {
                        case let .a(_, root):
                            ForEach(root.items) { SourceItemGroup(item: $0) }
                        case let .b(_, root):
                            ForEach(root.items) { SourceItemGroup(item: $0) }
                        case let .c(_, root):
                            ForEach(root.items) { SourceItemGroup(item: $0) }
                    }
                }
                .frame(minWidth: 200)
                
                VStack {
                    Text("Initial Content")
                    Text("SourceItems")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var model = SampleModel()

    static var previews: some View {
        ContentView(model: model)
            .preferredColorScheme(.dark)
        ContentView(model: model)
            .preferredColorScheme(.light)
    }
}
