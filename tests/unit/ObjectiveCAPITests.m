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

#import <XCTest/XCTest.h>

@import MaterialMotionCoreAnimationFamily;

@interface ObjectiveCAPITests : XCTestCase
@end

@implementation ObjectiveCAPITests

- (void)testTweenAPI {
  MDMTween *tween = [[MDMTween alloc] initWithKeyPath:@"opacity" duration:0.1];
  tween.delay = 0.1;
  tween.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
  tween.from = @2;
  tween.to = @2;
  XCTAssertEqualObjects(tween.keyPath, @"opacity");
  XCTAssertEqual(tween.duration, 0.1);
}

- (void)testKeyframeTweenAPI {
  MDMKeyframeTween *tween = [[MDMKeyframeTween alloc] initWithKeyPath:@"opacity" duration:0.1 values:@[ @0, @0.5 ]];
  tween.delay = 0.1;
  tween.timingFunctions = @[ [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn] ];
  tween.offsets = @[ @0, @1 ];
  XCTAssertEqualObjects(tween.keyPath, @"opacity");
  XCTAssertEqualObjects(tween.values[0], @0);
  XCTAssertEqualObjects(tween.values[1], @0.5);
  XCTAssertEqual(tween.duration, 0.1);
}

@end
