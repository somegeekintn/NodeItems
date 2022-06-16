//
//  StringContent.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

extension String {
    var content : some View { StringContent(value: self) }
}

struct StringContent: View {
    var value  : String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Value: \(value)")
                .font(.headline)
            Divider()
            Text("String Overview")
                .font(.largeTitle)
                .fontWeight(.light)
                .padding(.bottom)
            Text("A string is a series of characters, such as \"Swift\", that forms a collection. Strings in Swift are Unicode correct and locale insensitive, and are designed to be efficient. The String type bridges with the Objective-C class NSString and offers interoperability with C functions that works with strings.")
                .padding(.bottom, 4.0)
            Text("You can create new strings using string literals or string interpolations. A string literal is a series of characters enclosed in quotes.")
        }
    }
}

struct StringContent_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView { StringContent(value: "hello") }
            .preferredColorScheme(.dark)
        ScrollView { StringContent(value: "world") }
            .preferredColorScheme(.light)
    }
}
