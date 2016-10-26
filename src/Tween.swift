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

/** Interpolate a CALayer property from one value to another. */
@objc(MDMTween)
public final class Tween: NSObject, Plan {
  /** The key path of the property whose value will be tweened. */
  public var keyPath: String

  /** The duration of the animation in seconds. */
  public var duration: CFTimeInterval

  /** The delay of the animation in seconds. */
  public var delay: CFTimeInterval = 0

  /** The initial value of the tween. See CABasicAnimation documentation for more details. */
  public var from: AnyObject?

  /** The final value of the tween. See CABasicAnimation documentation for more details. */
  public var to: AnyObject?

  /**
   The timing function to apply to the animation.

   A nil timing function indicates linear pacing.
   */
  public var timingFunction: CAMediaTimingFunction?

  /**
   Initialize a tween with its required properties.
   */
  @objc(initWithKeyPath:duration:)
  public init(_ keyPath: String, duration: CFTimeInterval) {
    self.keyPath = keyPath
    self.duration = duration
    super.init()
  }

  /** The performer that will fulfill this plan. */
  public func performerClass() -> AnyClass {
    return TweenPerformer.self
  }
  /** Returns a copy of this plan. */
  public func copy(with zone: NSZone? = nil) -> Any {
    let tween = Tween(keyPath, duration: duration)
    tween.from = from
    tween.to = to
    tween.timingFunction = timingFunction
    tween.delay = delay
    return tween
  }
}
