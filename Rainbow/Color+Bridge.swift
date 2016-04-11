//
//  Color+Bridge.swift
//  Rainbow
//
//  Created by Alex Zimin on 07/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import UIKit

extension Color: CustomStringConvertible {
  public var description: String {
    return "\(self.dynamicType) \(self.hexString)"
  }
}

//extension Color: _ObjectiveCBridgeable {
//  public typealias _ObjectiveCType = UIColor
//  
//  public static func _isBridgedToObjectiveC() -> Bool {
//    return true
//  }
//  
//  public static func _getObjectiveCType() -> Any.Type {
//    return _ObjectiveCType.self
//  }
//  
//  public func _bridgeToObjectiveC() -> _ObjectiveCType {
//    return self.UIColorValue
//  }
//  
//  public static func _forceBridgeFromObjectiveC(source: _ObjectiveCType, inout result: Color?) {
//    result = Color(color: source)
//  }
//  
//  public static func _conditionallyBridgeFromObjectiveC(source: _ObjectiveCType, inout result: Color?) -> Bool {
//    self._forceBridgeFromObjectiveC(source, result: &result)
//    return true
//  }
//}