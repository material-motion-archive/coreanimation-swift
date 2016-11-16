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

// Allows a CALayer to be scrubbed by a Timeline.
final class TimelineScrubbable: NSObject, Plan {
  public var timeline: Timeline

  public init(_ timeline: Timeline) {
    self.timeline = timeline
    super.init()
  }

  public func performerClass() -> AnyClass {
    return Performer.self
  }

  public func copy(with zone: NSZone? = nil) -> Any {
    return TimelineScrubbable(timeline)
  }

  private class Performer: NSObject, Performing, TimelineObserving {
    let target: CALayer
    required init(target: Any) {
      self.target = target as! CALayer
    }

    func addPlan(_ plan: Plan) {
      let tween = plan as! TimelineScrubbable
      self.timeline = tween.timeline
    }

    var timeline: Timeline? {
      willSet {
        assert(self.timeline == nil || newValue == self.timeline,
               "Only one timeline may be associated with a layer at a time.")
      }
      didSet {
        if oldValue == nil, let timeline = timeline {
          timeline.addObserver(self)

          if timeline.beginTime == nil {
            timeline.begin()
          }

          if let scrubber = timeline.scrubber {
            self.timeline(timeline, didAttach: scrubber)
            self.timeline(timeline, scrubberDidScrub: scrubber.timeOffset)
          }
        }
      }
    }
    func timeline(_ timeline: Timeline, didAttach scrubber: TimelineScrubber) {
      assert(target.speed != 0, "Scrubbing is not supported on layers whose speed is already affected.")
      target.speed = 0
      target.timeOffset = timeline.beginTime!.doubleValue + scrubber.timeOffset
    }

    func timeline(_ timeline: Timeline, didDetach scrubber: TimelineScrubber) {
      let pausedTime = target.timeOffset
      target.speed = 1
      target.timeOffset = 0
      target.beginTime = 0
      let timeSincePause = target.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
      target.beginTime = timeSincePause
    }

    func timeline(_ timeline: Timeline, scrubberDidScrub timeOffset: TimeInterval) {
      target.timeOffset = timeline.beginTime!.doubleValue + timeOffset
    }
  }
}
