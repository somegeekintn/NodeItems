//
//  ContentView.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/14/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model : SampleModel
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    Divider()

                    Menu {
                        Picker("Variant", selection: $model.variant) {
                            ForEach(SampleModel.Variant.allCases.dropFirst()) { variant in
                                Text(variant.title).tag(variant)
                            }
                        }
                        .pickerStyle(.inline)
                    } label: {
                        Label("Variant", systemImage: "slider.horizontal.3")
                    }
                    
                    Divider()

                    switch model.base {
                        case let .a(_, title):
                            Text(title)
                        case let .b(_, root):
                            ForEach(root.children) {
                                SourceItemGroup(selection: $model.selection, item: $0)
                            }
                        case let .c(_, root):
                            ForEach(root.children) {
                                SourceItemGroup(selection: $model.selection, item: $0)
                            }
                        case let .d(_, root):
                            ForEach(root.children) {
                                SourceItemGroup(selection: $model.selection, item: $0)
                            }
                    }
                }
                .frame(minWidth: 200)
                
                VStack {
                    Text("Initial Content")
                    Text("SourceItems")
                }
            }
            .searchable(text: $model.filter, placement: .sidebar)
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
