//
//  ColorOnImage.swift
//  Rainbow
//
//  Created by Alex Zimin on 21/03/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

// Thanks to Indragie Karunaratne ( https://github.com/indragiek )

import UIKit

public enum GroupingAccuracy {
  case Low // CIE 76
  case Medium // CIE 94
  case High // CIE 2000
}

struct DefaultParameterValues {
  static var maxSampledPixels: Int = 1000
  static var accuracy: GroupingAccuracy = .Medium
  static var seed: UInt32 = 3571
}

private struct RGBAPixel {
  let r: UInt8
  let g: UInt8
  let b: UInt8
  let a: UInt8
}

extension RGBAPixel: Hashable {
  private var hashValue: Int {
    return (((Int(r) << 8) | Int(g)) << 8) | Int(b)
  }
}

private func ==(lhs: RGBAPixel, rhs: RGBAPixel) -> Bool {
  return lhs.r == rhs.r && lhs.g == rhs.g && lhs.b == rhs.b
}

private extension RGBAPixel {
  func toRGBVector() -> Optimize3DFloatVector {
    return Optimize3DFloatVector(
      x: Float(r) / Float(UInt8.max),
      y: Float(g) / Float(UInt8.max),
      z: Float(b) / Float(UInt8.max)
    )
  }
}

class ColorOnImage {
  
  static func dominantColorsInImage(
    image: CGImage,
    maxSampledPixels: Int = DefaultParameterValues.maxSampledPixels,
    accuracy: GroupingAccuracy = DefaultParameterValues.accuracy,
    seed: UInt32 = DefaultParameterValues.seed) -> [Color] {
      
      let (width, height) = (CGImageGetWidth(image), CGImageGetHeight(image))
      let (scaledWidth, scaledHeight) = scaledDimensionsForPixelLimit(maxSampledPixels, width: width, height: height)
      
      // Downsample the image if necessary, so that the total number of
      // pixels sampled does not exceed the specified maximum.
      let context = createRGBAContext(scaledWidth, height: scaledHeight)
      CGContextDrawImage(context, CGRect(x: 0, y: 0, width: Int(scaledWidth), height: Int(scaledHeight)), image)
      
      // Get the RGB colors from the bitmap context, ignoring any pixels
      // that have alpha transparency.
      // Also convert the colors to the LAB color space
      var labValues = [Vector3D]()
      labValues.reserveCapacity(Int(scaledWidth * scaledHeight))
      
      let RGBToLAB: RGBAPixel -> Vector3D = {
        let f: RGBAPixel -> Vector3D = { 
          let vector = $0.toRGBVector()
          return LABColor(r: vector.x, g: vector.y, b: vector.z).toVector()
        }
        return f
      }()
      
      enumerateRGBAContext(context) { (_, _, pixel) in
        if pixel.a == UInt8.max {
          labValues.append(RGBToLAB(pixel))
        }
      }
      // Cluster the colors using the k-means algorithm
      let k = selectKForElements(labValues)
      
      
      var clusters = kmeans(labValues, k: k, seed: seed, distance: distanceForAccuracy(accuracy))
      
      
      // Sort the clusters by size in descending order so that the
      // most dominant colors come first.
      clusters.sortInPlace { $0.size > $1.size }
      
      
      return clusters.map { (vector) -> Color in
        return LABColor(labVector: vector.centroid).color!
      }
      
  }
  
  private static func distanceForAccuracy(accuracy: GroupingAccuracy) -> (Vector3D, Vector3D) -> Float {
    switch accuracy {
    case .Low:
      return CIE76SquaredColorDifferenceFunction
    case .Medium:
      return {
        (lab1: Vector3D, lab2: Vector3D) -> Float in
        return CIE94SquaredColorDifferenceFunction(lab1: lab1, lab2: lab2)
      }
    case .High:
      return {
        (lab1: Vector3D, lab2: Vector3D) -> Float in
        return CIE2000SquaredColorDifferenceFunction(lab1: lab1, lab2: lab2)
      }
    }
  }
  
  private static func scaledDimensionsForPixelLimit(limit: Int, width: Int, height: Int) -> (Int, Int) {
    if (width * height > limit) {
      let ratio = Float(width) / Float(height)
      let maxWidth = sqrtf(ratio * Float(limit))
      return (Int(maxWidth), Int(Float(limit) / maxWidth))
    }
    return (width, height)
  }
  
  private static func createRGBAContext(width: Int, height: Int) -> CGContext {
    return CGBitmapContextCreate(
      nil,
      width,
      height,
      8, 
      width * 4,
      CGColorSpaceCreateDeviceRGB(),
      CGImageAlphaInfo.PremultipliedLast.rawValue
      )!
  }
  
  // Enumerates over all of the pixels in an RGBA bitmap context
  // in the order that they are stored in memory, for faster access.
  //
  // From: https://www.mikeash.com/pyblog/friday-qa-2012-08-31-obtaining-and-interpreting-image-data.html
  private static func enumerateRGBAContext(context: CGContext, handler: (Int, Int, RGBAPixel) -> Void) {
    let (width, height) = (CGBitmapContextGetWidth(context), CGBitmapContextGetHeight(context))
    let data = unsafeBitCast(CGBitmapContextGetData(context), UnsafeMutablePointer<RGBAPixel>.self)
    for y in 0..<height {
      for x in 0..<width {
        handler(x, y, data[Int(x + y * width)])
      }
    }
  }
  
  private static func selectKForElements<T>(elements: [T]) -> Int {
    // Seems like a magic number...
    return 6
  }
}