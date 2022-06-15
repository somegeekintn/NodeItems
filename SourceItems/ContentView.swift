//
//  ContentView.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/14/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model   : SampleModel
    @State var toggle           : Bool = false
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    Toggle(isOn: $toggle) {
                        Text("Toggle").padding(.leading, 4.0)
                    }
                    
                    if !toggle {
                        ForEach(model.items1) {
                            SourceItemGroup(item: $0)
                        }
                    }
                    else {
                        ForEach(model.items2) {
                            SourceItemGroup(item: $0)
                        }
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
