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
import MaterialMotionCoreAnimation

// This example demonstrates how to control a Tween animation using a Timeline.
class ScrollDrivenAnimationExampleViewController: UIViewController, UIScrollViewDelegate {

  let runtime = Runtime()

  // We use this timeline to map the scroll view's content offset to our tween animation.
  let timeline = Timeline()

  var scrollView: UIScrollView!
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    scrollView = UIScrollView(frame: view.bounds)
    scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    scrollView.contentSize = .init(width: view.bounds.width, height: view.bounds.height * 10)
    scrollView.delegate = self
    view.addSubview(scrollView)

    let squareView = UIView(frame: .init(x: view.bounds.width / 2 - 25,
                                         y: view.bounds.height / 2 - 25,
                                         width: 50, height: 50))
    squareView.backgroundColor = .red
    scrollView.addSubview(squareView)

    // In order to control the tween's progress we must attach a scrubber to the timeline.
    // If we detach the scrubber (by setting it to nil) the animation will continue from where it
    // left off.
    timeline.scrubber = TimelineScrubber()

    // Note that we're hacking the duration value here to represent positional units. This works
    // because we never actually intend to disconnect the scrubber from the timeline. If we ever
    // wanted the animation to continue on its own in real time we'd have to use proper time units
    // here and convert the content offset accordingly.
    let tween = Tween("transform.rotation.z", duration: 200, values: [0, M_PI])

    // Must associate the tween with our timeline or the timeline won't be able to scrub it.
    tween.timeline = timeline

    runtime.addPlan(tween, to: squareView.layer)
  }

  // MARK: UIScrollViewDelegate

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y + scrollView.contentInset.top

    // The magic. When we set this value it informs the timeline of the change, which then informs
    // all performers that have subscribed to that timeline of the change (our Tween, in this case).
    timeline.scrubber?.timeOffset = abs(TimeInterval(offset))
  }
}
