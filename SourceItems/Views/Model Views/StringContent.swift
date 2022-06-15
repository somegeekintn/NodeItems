//
//  StringContent.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

extension StringSource {
    var content : some View { StringContent(source: self) }
}

struct StringContent: View {
    var source  : StringSource

    var body: some View {
        VStack(alignment: .leading) {
            Text("Value: \(source.value)")
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
        ScrollView { StringContent(source: StringSource(value: "hello")) }
            .preferredColorScheme(.dark)
        ScrollView { StringContent(source: StringSource(value: "world")) }
            .preferredColorScheme(.light)
    }
}
