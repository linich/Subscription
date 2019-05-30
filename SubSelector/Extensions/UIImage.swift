//
//  File.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/30/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit


extension UIImage {
      static func downloadImage(url: NSURL, to pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as NSDictionary
        guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, imageSourceOptions) else {
            return nil
        }

        let maxDemensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDemensionInPixels
        ] as CFDictionary

        guard let downsampleImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        return self.init(cgImage: downsampleImage)
    }
}
