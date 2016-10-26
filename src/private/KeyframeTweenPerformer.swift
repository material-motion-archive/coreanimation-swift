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

class KeyframeTweenPerformer: NSObject, PlanPerforming, ContinuousPerforming {
  let target: CALayer
  required init(target: Any) {
    if let view = target as? UIView {
      self.target = view.layer
    } else {
      self.target = target as! CALayer
    }
  }

  func addPlan(_ plan: Plan) {
    let tween = plan as! KeyframeTween

    let animation = CAKeyframeAnimation(keyPath: tween.keyPath)
    animation.values = tween.values
    animation.keyTimes = tween.offsets as [NSNumber]?
    animation.timingFunctions = tween.timingFunctions
    animation.duration = tween.duration
    animation.beginTime = tween.delay

    guard let token = tokenGenerator.generate() else { return }

    CATransaction.begin()

    CATransaction.setCompletionBlock {
      token.terminate()
    }

    target.add(animation, forKey: nil)

    CATransaction.commit()
  }

  var tokenGenerator: IsActiveTokenGenerating!
  func set(isActiveTokenGenerator: IsActiveTokenGenerating) {
    tokenGenerator = isActiveTokenGenerator
  }
}
