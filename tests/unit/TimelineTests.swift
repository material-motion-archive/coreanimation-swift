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

import XCTest
import MaterialMotionRuntime
import MaterialMotionCoreAnimation

class TimelineTests: XCTestCase {

  func testScrubberModifiesLayerTimeOffset() {
    let view = UIView()

    let runtime = Runtime()
    let timeline = Timeline()
    let scrubber = TimelineScrubber()
    timeline.scrubber = scrubber

    let animation = Tween("opacity", duration: 0.1, values: [0, 1])
    animation.timeline = timeline
    runtime.addPlan(animation, to: view.layer)

    XCTAssertEqual(view.layer.timeOffset, TimeInterval(timeline.beginTime!.doubleValue))

    scrubber.timeOffset = 0.1

    XCTAssertEqual(view.layer.timeOffset,
                   TimeInterval(timeline.beginTime!.doubleValue + scrubber.timeOffset))
  }

  func testDetachedScrubberDoesNotModifyLayerTimeOffset() {
    let view = UIView()

    let runtime = Runtime()
    let timeline = Timeline()
    let scrubber = TimelineScrubber()
    timeline.scrubber = scrubber

    let animation = Tween("opacity", duration: 0.1, values: [0, 1])
    animation.timeline = timeline
    runtime.addPlan(animation, to: view.layer)

    XCTAssertEqual(view.layer.timeOffset, TimeInterval(timeline.beginTime!.doubleValue))

    timeline.scrubber = nil
    scrubber.timeOffset = 0.1

    XCTAssertNotEqual(view.layer.timeOffset,
                      TimeInterval(timeline.beginTime!.doubleValue + scrubber.timeOffset))
  }
}
