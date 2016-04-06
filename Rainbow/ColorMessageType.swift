//
//  ColorMessages.swift
//  Rainbow
//
//  Created by Alex Zimin on 06/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

func <<<T: ColorMessageGenericType>(left: Color?, right: T) -> T.Generated? {
  guard let left = left else {
    return nil
  }
  return right.execute(left)
}

func <<<T: ColorMessageGenericType>(left: Color, right: T) -> T.Generated {
  return right.execute(left)
}

protocol ColorMessageGenericType {
  associatedtype Generated
  func execute(color: Color) -> Generated
}

protocol ColorMessageEmptyType {
  associatedtype Generated
  func execute() -> Generated
}