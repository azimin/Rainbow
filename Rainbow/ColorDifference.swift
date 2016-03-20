//
//  ColorDifference.swift
//  Rainbow
//
//  Created by Alex Zimin on 20/03/16.
//  Copyright © 2016 Alex Zimin. All rights reserved.
//

// Thanks to Indragie Karunaratne ( https://github.com/indragiek )

import GLKit.GLKMath

internal protocol ColorDifference {
  func colorDifference(lab1: LABColor, lab2: LABColor) -> Float
}

internal struct CIE76SquaredColorDifference: ColorDifference {
  
  // From http://www.brucelindbloom.com/index.html?Eqn_DeltaE_CIE76.html
  
  func colorDifference(lab1: LABColor, lab2: LABColor) -> Float {
    return CIE76SquaredColorDifferenceFunction(lab1.toVector(), lab2: lab2.toVector())
  }
}

internal func CIE76SquaredColorDifferenceFunction(lab1: Vector3D, lab2: Vector3D) -> Float {
  let (L1, a1, b1) = lab1.toFloatTuple()
  let (L2, a2, b2) = lab2.toFloatTuple()
  return pow(L2 - L1, 2) + pow(a2 - a1, 2) + pow(b2 - b1, 2)
}

internal struct CIE94SquaredColorDifference: ColorDifference {
  
  private(set) var kL: Float
  private(set) var kC: Float
  private(set) var kH: Float
  private(set) var K1: Float
  private(set) var K2: Float
  
  init(kL: Float = 1, kC: Float = 1, kH: Float = 1, K1: Float = 0.045, K2: Float = 0.015) {
    self.kL = kL
    self.kC = kC
    self.kH = kH
    self.K1 = K1
    self.K2 = K2
  }
  
  func colorDifference(lab1: LABColor, lab2: LABColor) -> Float {
    return CIE94SquaredColorDifferenceFunction(kL, kC: kC, kH: kH, K1: K1, K2: K2, lab1: lab1, lab2: lab2)
  }
}

// From http://www.brucelindbloom.com/index.html?Eqn_DeltaE_CIE94.html
// Created for optimization

internal func CIE94SquaredColorDifferenceFunction(kL: Float = 1, kC: Float = 1, kH: Float = 1, K1: Float = 0.045, K2: Float = 0.015, lab1: LABColor, lab2: LABColor) -> Float {
  return CIE94SquaredColorDifferenceFunction(kL, kC: kC, kH: kH, K1: K1, K2: K2, lab1: lab1.toVector(), lab2: lab1.toVector())
}

internal func CIE94SquaredColorDifferenceFunction(kL: Float = 1, kC: Float = 1, kH: Float = 1, K1: Float = 0.045, K2: Float = 0.015, lab1: Vector3D, lab2: Vector3D) -> Float {
  let (L1, a1, b1) = lab1.toFloatTuple()
  let (L2, a2, b2) = lab2.toFloatTuple()
  
  let ΔL = L1 - L2
  
  let (C1, C2) = (C(a1, b: b1), C(a2, b: b2))
  let ΔC = C1 - C2
  
  let ΔH = sqrt(pow(a1 - a2, 2) + pow(b1 - b2, 2) - pow(ΔC, 2))
  
  let Sl: Float = 1
  let Sc = 1 + K1 * C1
  let Sh = 1 + K2 * C1
  
  return pow(ΔL / (kL * Sl), 2) + pow(ΔC / (kC * Sc), 2) + pow(ΔH / (kH * Sh), 2)
}

internal struct CIE2000SquaredColorDifference: ColorDifference {
  
  private(set) var kL: Float
  private(set) var kC: Float
  private(set) var kH: Float
  
  init(kL: Float = 1, kC: Float = 1, kH: Float = 1) {
    self.kL = kL
    self.kC = kC
    self.kH = kH
  }
  
  func colorDifference(lab1: LABColor, lab2: LABColor) -> Float {
    return CIE2000SquaredColorDifferenceFunction(kL, kC: kC, kH: kH, lab1: lab1, lab2: lab2)
  }
}

// From http://www.brucelindbloom.com/index.html?Eqn_DeltaE_CIE2000.html
// Created for optimization

internal func CIE2000SquaredColorDifferenceFunction(kL: Float = 1, kC: Float = 1, kH: Float = 1, lab1: LABColor, lab2: LABColor) -> Float {
  return CIE2000SquaredColorDifferenceFunction(kL, kC: kC, kH: kH, lab1: lab1.toVector(), lab2: lab2.toVector())
}

internal func CIE2000SquaredColorDifferenceFunction(kL: Float = 1, kC: Float = 1, kH: Float = 1, lab1: Vector3D, lab2: Vector3D) -> Float {
  
  let (L1, a1, b1) = lab1.toFloatTuple()
  let (L2, a2, b2) = lab2.toFloatTuple()
  
  let ΔLp = L2 - L1
  let Lbp = (L1 + L2) / 2
  
  let (C1, C2) = (C(a1, b: b1), C(a2, b: b2))
  let Cb = (C1 + C2) / 2
  
  let G = (1 - sqrt(pow(Cb, 7) / (pow(Cb, 7) + pow(25, 7)))) / 2
  let ap: Float -> Float = { a in
    return a * (1 + G)
  }
  let (a1p, a2p) = (ap(a1), ap(a2))
  
  let (C1p, C2p) = (C(a1p, b: b1), C(a2p, b: b2))
  let ΔCp = C2p - C1p
  let Cbp = (C1p + C2p) / 2
  
  let hp: (Float, Float) -> Float = { ap, b in
    if ap == 0 && b == 0 { return 0 }
    let θ = GLKMathRadiansToDegrees(atan2(b, ap))
    return fmod(θ < 0 ? (θ + 360) : θ, 360)
  }
  let (h1p, h2p) = (hp(a1p, b1), hp(a2p, b2))
  let Δhabs = abs(h1p - h2p)
  let Δhp: Float = {
    if (C1p == 0 || C2p == 0) {
      return 0
    } else if Δhabs <= 180 {
      return h2p - h1p
    } else if h2p <= h1p {
      return h2p - h1p + 360
    } else {
      return h2p - h1p - 360
    }
  }()
  
  let ΔHp = 2 * sqrt(C1p * C2p) * sin(GLKMathDegreesToRadians(Δhp / 2))
  let Hbp: Float = {
    if (C1p == 0 || C2p == 0) {
      return h1p + h2p
    } else if Δhabs > 180 {
      return (h1p + h2p + 360) / 2
    } else {
      return (h1p + h2p) / 2
    }
  }()
  
  var T = 1 - 0.17 * cos(GLKMathDegreesToRadians(Hbp - 30))
  T += 0.24 * cos(GLKMathDegreesToRadians(2 * Hbp))
  T += 0.32 * cos(GLKMathDegreesToRadians(3 * Hbp + 6))
  T -= 0.20 * cos(GLKMathDegreesToRadians(4 * Hbp - 63))
  
  let Sl = 1 + (0.015 * pow(Lbp - 50, 2)) / sqrt(20 + pow(Lbp - 50, 2))
  let Sc = 1 + 0.045 * Cbp
  let Sh = 1 + 0.015 * Cbp * T
  
  let Δθ = 30 * exp(-pow((Hbp - 275) / 25, 2))
  let Rc = 2 * sqrt(pow(Cbp, 7) / (pow(Cbp, 7) + pow(25, 7)))
  let Rt = -Rc * sin(GLKMathDegreesToRadians(2 * Δθ))
  
  let Lterm = ΔLp / (kL * Sl)
  let Cterm = ΔCp / (kC * Sc)
  let Hterm = ΔHp / (kH * Sh)
  return pow(Lterm, 2) + pow(Cterm, 2) + pow(Hterm, 2) + Rt * Cterm * Hterm
}
