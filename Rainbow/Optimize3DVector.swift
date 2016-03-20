//
//  Optimize3DVector.swift
//  Rainbow
//
//  Created by Alex Zimin on 20/03/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

protocol OptimizeVector3DType {
  func toFloatTuple() -> (Float, Float, Float)
  func toCGFloatTuple() -> (CGFloat, CGFloat, CGFloat) 
  func toDoubleTuple() -> (Double, Double, Double) 
}

struct Optimize3DFloatVector: OptimizeVector3DType {
  var x: Float
  var y: Float
  var z: Float
  
  init(labTuple: LABTuple) {
    x = labTuple.l
    y = labTuple.a
    z = labTuple.b
  }
  
  init(x: Float, y: Float, z: Float) {
    self.x = x
    self.y = y
    self.z = z
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

struct Optimize3DCGFloatVector: OptimizeVector3DType {
  var x: CGFloat
  var y: CGFloat
  var z: CGFloat
  
  func toFloatTuple() -> (Float, Float, Float) {
    return (x.toFloat(), y.toFloat(), z.toFloat())
  }
  
  func toCGFloatTuple() -> (CGFloat, CGFloat, CGFloat) {
    return (x, y, z)
  }
  
  func toDoubleTuple() -> (Double, Double, Double)  {
    return (x.toDouble(), y.toDouble(), z.toDouble())
  }
}

struct Optimize3DDoubleVector: OptimizeVector3DType {
  var x: Double
  var y: Double
  var z: Double
  
  func toFloatTuple() -> (Float, Float, Float) {
    return (x.toFloat(), y.toFloat(), z.toFloat())
  }
  
  func toCGFloatTuple() -> (CGFloat, CGFloat, CGFloat) {
    return (x.toCGFloat(), y.toCGFloat(), z.toCGFloat())
  }
  
  func toDoubleTuple() -> (Double, Double, Double)  {
    return (x, y, z)
  }
}

// MARK: -

extension Optimize3DFloatVector: ClusteredType {
  static var identity: Optimize3DFloatVector {
    return Optimize3DFloatVector(x: 0, y: 0, z: 0)
  }
}

func +(lhs: Optimize3DFloatVector, rhs: Optimize3DFloatVector) -> Optimize3DFloatVector {
  return Optimize3DFloatVector(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
}

func /(lhs: Optimize3DFloatVector, rhs: Float) -> Optimize3DFloatVector {
  return Optimize3DFloatVector(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
}

func /(lhs: Optimize3DFloatVector, rhs: Int) -> Optimize3DFloatVector {
  return lhs / Float(rhs)
}