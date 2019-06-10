//
//  ImageConvert.swift
//  Instagrids
//
//  Created by stephane verardo on 05/06/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import UIKit

enum Layout{
    case layout1, layout2, layout3
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext)
        }
        
    }
}
