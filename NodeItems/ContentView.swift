//
//  ContentView.swift
//  NodeItems
//
//  Created by Casey Fleser on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model  = SampleModel()
    @State var isFiltered   = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Menu(
                    content: {
                        Picker("Variant", selection: $model.variant) {
                            ForEach(SampleModel.Variant.selectable, id: \.self) { variant in
                                Text(variant.title).tag(variant)
                            }
                        }
                        .pickerStyle(.inline)
                    },
                    label: {
                        Label("Variant", systemImage: "slider.horizontal.3")
                    }
                )
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                
                Toggle("Filtered", isOn: $isFiltered)
                    .padding(.horizontal)
                
                Divider()

FilteredNodeView
{
    42
    ("hello") {
        "world"
        27
        (99) {
            "ninety-nine"
        }
    }
}
//                Group {
//                    if isFiltered {
//                        FilteredNodeView() { model.items }
//                    }
//                    else {
//                        NodeView { model.items }
//                    }
//                }
                .frame(minWidth: 200)
                .id(model.variant)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
