//
//  SourceItemsApp.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/14/22.
//

import SwiftUI

@main
struct SourceItemsApp: App {
    @StateObject private var model = SampleModel()

    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
        .windowStyle(.hiddenTitleBar)
    }
}
