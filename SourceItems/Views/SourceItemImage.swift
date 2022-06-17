//
//  SourceItemImage.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

struct SourceItemImage: View {
    var imageDesc       : SourceImageDesc
    var isLabelImage    = true
    var imageSize       : CGFloat?

    var body: some View {
        let size    = imageSize ?? (isLabelImage ? 20.0 : 128.0)

        switch imageDesc {
            case let .icon(nsImage):
                Image(nsImage: nsImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: size, maxHeight: size)
                    .cornerRadius(size / 5.0)
                    .shadow(radius: 4.0, x: 2.0, y: 2.0)
                    
            case let .symbol(systemName, color):
                if isLabelImage {
                    Image(systemName: systemName)
                        .foregroundColor(color)
                        .symbolRenderingMode(.hierarchical)
                }
                else {
                    Image(systemName: systemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: size, maxHeight: size)
                        .shadow(radius: 4.0, x: 2.0, y: 2.0)
                }
        }
    }
}

struct SourceItemImage_Previews: PreviewProvider {
    static var sampleImage1 = SampleModel().items1[0].imageDesc
    static var sampleImage2 = SampleModel().items2[0].imageDesc

    static var previews: some View {
        SourceItemImage(imageDesc: sampleImage1)
        SourceItemImage(imageDesc: sampleImage1, isLabelImage: false)
        SourceItemImage(imageDesc: sampleImage2)
        SourceItemImage(imageDesc: sampleImage2, isLabelImage: false)
    }
}
