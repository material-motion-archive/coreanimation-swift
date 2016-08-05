/*
 Copyright 2016-present The Material Motion Authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import UIKit
import MaterialMotionRuntime

/**
 Conforming to MDMPlan enables use of CAAnimation objects as plans in a Material Motion runtime.
 */
extension CAAnimation: Plan {

  /** Implementing this method bridges Core Animation with the Material Motion runtime. */
  public func performerClass() -> AnyClass {
    return CoreAnimationPerformer.self
  }
}

/** A light-weight Core Animation Material Motion performer. */
@objc class CoreAnimationPerformer: NSObject, PlanPerforming, DelegatedPerforming {
  let target: CALayer
  var willStart: DelegatedPerformanceTokenReturnBlock!
  var didEnd: DelegatedPerformanceTokenArgBlock!

  required init(target: AnyObject) {
    if let view = target as? UIView {
      self.target = view.layer
    } else {
      self.target = target as! CALayer
    }
  }

  func add(plan: Plan) {
    CATransaction.begin()

    guard let token = self.willStart() else { return }
    CATransaction.setCompletionBlock {
      self.didEnd(token)
    }

    let animation = plan as! CAAnimation
    self.target.add(animation, forKey: nil)

    CATransaction.commit()
  }

  func setDelegatedPerformance(willStart: DelegatedPerformanceTokenReturnBlock, didEnd: DelegatedPerformanceTokenArgBlock) {
    self.willStart = willStart
    self.didEnd = didEnd
  }
}
