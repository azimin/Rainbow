//
//  ColorMessageContrast.swift
//  Rainbow
//
//  Created by Alex Zimin on 07/04/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

import Foundation

struct ColorMessageContrast: ColorMessageGenericType {
  typealias Generated = Color
  func execute(color: Color) -> Color {
    return color.contrastingBlackOrWhite()
  }
}