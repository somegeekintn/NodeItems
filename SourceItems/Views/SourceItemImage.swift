//
//  SourceItemImage.swift
//  SourceItems
//
//  Created by Casey Fleser on 6/15/22.
//

import SwiftUI

struct SourceItemImage: View {
    var styledImage     : SourceImage
    var isLabelImage    = true
    var imageSize       : CGFloat?

    var body: some View {
        let size    = imageSize ?? (isLabelImage ? 20.0 : 128.0)

        switch styledImage.style {
            case .icon:
                
                styledImage.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: size, maxHeight: size)
                    .cornerRadius(size / 5.0)
                    .shadow(radius: 4.0, x: 2.0, y: 2.0)
                    
            case let .symbol(color):
                if isLabelImage {
                    styledImage.image
                        .foregroundColor(color)
                        .symbolRenderingMode(.hierarchical)
                }
                else {
                    styledImage.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: size, maxHeight: size)
                        .shadow(radius: 4.0, x: 2.0, y: 2.0)
                }
        }
    }
}

struct SourceItemImage_Previews: PreviewProvider {
    static var sampleImage1 = SampleModel().items1[0].image
    static var sampleImage2 = SampleModel().items2[0].image

    static var previews: some View {
        SourceItemImage(styledImage: sampleImage1)
        SourceItemImage(styledImage: sampleImage1, isLabelImage: false)
        SourceItemImage(styledImage: sampleImage2)
        SourceItemImage(styledImage: sampleImage2, isLabelImage: false)
    }
}
