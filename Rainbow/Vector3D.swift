//
//  Vector3D.swift
//  Rainbow
//
//  Created by Alex Zimin on 21/03/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

struct Vector3D: OptimizeVector3DType {
  var x: Float
  var y: Float
  var z: Float
  
  init(x: Float, y: Float, z: Float) {
    self.x = x
    self.y = y
    self.z = z
  }
  
  init(tuple: (Float, Float, Float)) {
    self.x = tuple.0
    self.y = tuple.1
    self.z = tuple.2
  }
  
  func toFloatTuple() -> (Float, Float, Float) {
    return (x, y, z)
  }
  
  func toCGFloatTuple() -> (CGFloat, CGFloat, CGFloat) {
    return (x.toCGFloat(), y.toCGFloat(), z.toCGFloat())
  }
  
  func toDoubleTuple() -> (Double, Double, Double)  {
    return (x.toDouble(), y.toDouble(), z.toDouble())
  }
}

// MARK: -

extension Vector3D: ClusteredType {
  static var identity: Vector3D {
    return Vector3D(x: 0, y: 0, z: 0)
  }
}

func +(lhs: Vector3D, rhs: Vector3D) -> Vector3D {
  return Vector3D(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
}

func /(lhs: Vector3D, rhs: Float) -> Vector3D {
  return Vector3D(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
}

func /(lhs: Vector3D, rhs: Int) -> Vector3D {
  return lhs / Float(rhs)
}