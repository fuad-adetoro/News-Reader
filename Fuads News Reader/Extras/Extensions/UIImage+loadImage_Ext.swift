//
//  UIImage+loadImage_Ext.swift
//  Fuads News Reader
//
//  Created by FA on 18/07/2021.
//

import UIKit

extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
