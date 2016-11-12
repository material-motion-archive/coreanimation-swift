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

class TweenPerformer: NSObject, ContinuousPerforming, ComposablePerforming {
  let target: CALayer
  required init(target: Any) {
    if let view = target as? UIView {
      self.target = view.layer
    } else {
      self.target = target as! CALayer
    }
  }

  func addPlan(_ plan: Plan) {
    let tween = plan as! Tween

    let values: [Any]
    if tween.values != nil {
      values = tween.values
    } else if let from = tween.from, let to = tween.to {
      values = [from, to]
    } else if let from = tween.from {
      assertionFailure("Nil to value and non-nil from value is unsupported as of v2.0.0.")
      values = []
    } else if let to = tween.to {
      values = [to]
    } else {
      assertionFailure("No value provided.")
      values = []
    }

    let timingFunctions: [CAMediaTimingFunction]?
    if tween.timingFunctions != nil {
      timingFunctions = tween.timingFunctions
    } else if let timingFunction = tween.timingFunction {
      timingFunctions = [timingFunction]
    } else {
      timingFunctions = nil
    }

    let animation: CAAnimation
    if values.count > 1 {
      let keyframeAnimation = CAKeyframeAnimation(keyPath: tween.keyPath)
      keyframeAnimation.values = values
      keyframeAnimation.keyTimes = tween.keyPositions?.map { NSNumber(value: $0) }
      keyframeAnimation.timingFunctions = timingFunctions
      animation = keyframeAnimation
    } else {
      let basicAnimation = CABasicAnimation(keyPath: tween.keyPath)
      basicAnimation.toValue = values.last
      basicAnimation.timingFunction = timingFunctions?.first
      animation = basicAnimation
    }
    animation.duration = tween.duration
    if let timeline = tween.timeline {
      emitter.emitPlan(TimelineScrubbable(timeline))
      animation.beginTime = target.convertTime(timeline.beginTime!.doubleValue, to: nil) + tween.delay
    } else {
      animation.beginTime = target.convertTime(CACurrentMediaTime(), to: nil) + tween.delay
    }

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

  var emitter: PlanEmitting!
  func setPlanEmitter(_ planEmitter: PlanEmitting) {
    emitter = planEmitter
  }
}
