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

/** Interpolate a CALayer property between many values. */
@objc(MDMKeyframeTween)
public class KeyframeTween: NSObject, Plan {
  /** The key path of the property whose value will be animated. */
  public var keyPath: String

  /** The duration of the animation in seconds. */
  public var duration: CFTimeInterval

  /** The delay of the animation in seconds. */
  public var delay: CFTimeInterval = 0

  /**
   An array of objects providing the value of the animation function for each keyframe.

   See CAKeyframeAnimation documentation for more details.
   */
  public var values: [Any]

  /**
   An optional array of double values defining the pacing of the animation. Each offset
   corresponds to one value in the `values' array, and defines when the value should be used in the
   animation function. Each value in the array is a floating point number in the range [0,1].

   See CAKeyframeAnimation documentation for more details.
   */
  public var offsets: [Double]?

  /**
   An optional array of CAMediaTimingFunction objects. If the `values' array defines n keyframes,
   there should be n-1 objects in the `timingFunctions' array. Each function describes the pacing of
   one keyframe to keyframe segment.

   See CAKeyframeAnimation documentation for more details.
   */
  public var timingFunctions: [CAMediaTimingFunction]?

  /**
   Initialize a keyframe tween with its required properties.
   */
  @objc(initWithKeyPath:duration:values:)
  public init(_ keyPath: String, duration: TimeInterval, values: [Any]) {
    self.keyPath = keyPath
    self.duration = duration
    self.values = values
    super.init()
  }

  /** The performer that will fulfill this plan. */
  public func performerClass() -> AnyClass {
    return KeyframeTweenPerformer.self
  }

  /** Returns a copy of this plan. */
  public func copy(with zone: NSZone? = nil) -> Any {
    let tween = KeyframeTween(keyPath, duration: duration, values: values)
    tween.offsets = offsets
    tween.timingFunctions = timingFunctions
    return tween
  }
}
