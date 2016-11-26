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

import MaterialMotionRuntime

extension MotionRuntime {
  /**
   Generates Tween plans for any animatable properties that are modified during the animations.

   Each Tween will use the system default ease in/out timing function.
   */
  public func tween(withDuration duration: TimeInterval, animations: () -> Void) {
    tween(withDuration: duration,
          timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
          animations: animations)
  }

  /**
   Generates Tween plans with a specific timing function for any animatable properties that are
   modified during the animations.
   */
  public func tween(withDuration duration: TimeInterval,
                    timingFunction: CAMediaTimingFunction,
                    animations: () -> Void) {
    installCoreAnimationTweenActionHandler()

    tweenActionContext = TweenActionContext(duration: duration)

    animations()

    for tweenAction in tweenActionContext!.tweenActions {
      let currentValue = tweenAction.target.value(forKeyPath: tweenAction.tween.keyPath)!
      tweenAction.tween.values.append(currentValue)
      tweenAction.tween.timingFunctions = [timingFunction]
      addPlan(tweenAction.tween, to: tweenAction.target)
    }
    tweenActionContext = nil
  }
}
