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

struct TweenAction {
  let tween: Tween
  let target: CALayer
}

class TweenActionContext {
  let duration: TimeInterval
  var tweenActions: [TweenAction] = []

  init(duration: TimeInterval) {
    self.duration = duration
  }
}

var tweenActionContext: TweenActionContext?

extension UIView {
  func mdm_action(for layer: CALayer, forKey event: String) -> CAAction? {
    if let context = tweenActionContext {
      let value = layer.value(forKeyPath: event)!
      let tween = Tween(event, duration: context.duration, values: [value])
      context.tweenActions.append(TweenAction(tween: tween, target: layer))

      // Must return NSNull in order to indicate to Core Animation that we don't want it to
      // create an animation for us
      return NSNull()
    }
    return self.mdm_action(for: layer, forKey: event)
  }
}

var didInject = false

extension MotionRuntime {
  func installCoreAnimationTweenActionHandler() {
    if didInject {
      return
    }
    didInject = true
    let originalSelector = #selector(CALayerDelegate.action(for:forKey:))
    let swizzledSelector = #selector(UIView.mdm_action(for:forKey:))
    let originalMethod = class_getInstanceMethod(UIView.self, originalSelector)
    let swizzledMethod = class_getInstanceMethod(UIView.self, swizzledSelector)

    let didAddMethod = class_addMethod(UIView.self,
                                       originalSelector,
                                       method_getImplementation(swizzledMethod),
                                       method_getTypeEncoding(swizzledMethod))

    if didAddMethod {
      class_replaceMethod(UIView.self,
                          swizzledSelector,
                          method_getImplementation(originalMethod),
                          method_getTypeEncoding(originalMethod))
    } else {
      method_exchangeImplementations(originalMethod,
                                     swizzledMethod)
    }
  }
}
