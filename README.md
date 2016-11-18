# Core Animation for Material Motion (Swift)

[![Build Status](https://travis-ci.org/material-motion/coreanimation-swift.svg?branch=develop)](https://travis-ci.org/material-motion/coreanimation-swift)
[![codecov](https://codecov.io/gh/material-motion/coreanimation-swift/branch/develop/graph/badge.svg)](https://codecov.io/gh/material-motion/coreanimation-swift)

This library provides a bridge between
[Core Animation](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html) and the
[Material Motion runtime](https://github.com/material-motion/runtime-objc).

## Supported languages

- Swift 3
- Objective-C

## Features

`Tween` uses Core Animation's CAKeyframeAnimation to animate a CALayer property along an easing
curve.

Use a Tween like you would use a CAKeyframeAnimation instance: provide a key path, duration, and
an array of values. Note that Tweens must be associated with CALayer instances.

```swift
let tweenBackgroundColor = Tween("backgroundColor",
                                 duration: animDuration,
                                 values: [UIColor.orange.cgColor, UIColor.lightGray.cgColor])
scheduler.addPlan(tweenBackgroundColor, to: myView.layer)
```

Tween's properties map to the following Core Animation properties:

| Tween | Core Animation |
|:-----:|:--------------:|
| delay  | delay |
| duration  | duration |
| keyPath  | keyPath |
| keyPositions  | keyTimes |
| timingFunctions  | timingFunctions |
| values  | values |

No other Core Animation properties are presently supported. View our filed
[feature requests](https://github.com/material-motion/coreanimation-swift/labels/Feature%20request)
to track progress on supporting additional functionality.

## Installation

### Installation with CocoaPods

> CocoaPods is a dependency manager for Objective-C and Swift libraries. CocoaPods automates the
> process of using third-party libraries in your projects. See
> [the Getting Started guide](https://guides.cocoapods.org/using/getting-started.html) for more
> information. You can install it with the following command:
>
>     gem install cocoapods

Add `MaterialMotionCoreAnimation` to your `Podfile`:

    pod 'MaterialMotionCoreAnimation'

Then run the following command:

    pod install

### Usage

Import the framework:

    @import MaterialMotionCoreAnimation;

You will now have access to all of the APIs.

## Example apps/unit tests

Check out a local copy of the repo to access the Catalog application by running the following
commands:

    git clone https://github.com/material-motion/coreanimation-swift.git
    cd coreanimation-swift
    pod install
    open MaterialMotionCoreAnimation.xcworkspace

## Guides

1. [How to animate a property with a Tween plan](#how-to-animate-a-property-with-a-tween-plan)
2. [How to commit Tween values to a layer](#how-to-commit-tween-values-to-a-layer)

### How to animate a property with a Tween plan

Code snippets:

***In Objective-C:***

```objc
MDMTween *tween = [[MDMTween alloc] initWithKeyPath:@"<#key path#>"
                                           duration:<#duration#>
                                             values:@[<#values...#>]];
[scheduler addPlan:tween to:<#CALayer#>];
```

***In Swift:***

```swift
let tween = Tween(<#key path#>, duration: <#duration#>, values: [<#values...#>])
scheduler.addPlan(tween, to: <#CALayer#>)
```

### How to animate a property with just a destination value

Provide Tween with a single value and it will treat this value as the `toValue` of a
CABasicAnimation. As per the Core Animation documentation:

> Interpolates between the layer's current value of the property in the render tree and `toValue'.

Code snippets:

***In Objective-C:***

```objc
MDMTween *tween = [[MDMTween alloc] initWithKeyPath:@"<#key path#>"
                                           duration:<#duration#>
                                             values:@[<#value#>]];
[scheduler addPlan:tween to:<#CALayer#>];
```

***In Swift:***

```swift
let tween = Tween(<#key path#>, duration: <#duration#>, values: [<#value#>])
scheduler.addPlan(tween, to: <#CALayer#>)
```

### How to commit Tween values to a layer

We provide two helper APIs for committing the to/from value of a Tween plan to a given CALayer
instance. This is most often used to commit the `to` value of the Tween to the layer so that the
property does not appear to "snap back" upon completion of the animation.

Code snippets:

***In Objective-C:***

```objc
[tween commitFirstValueTo:<#CALayer#>];
[tween commitLastValueTo:<#CALayer#>];
```

***In Swift:***

```swift
tween.commitFirstValue(to: <#CALayer#>)
tween.commitLastValue(to: <#CALayer#>)
```

## Contributing

We welcome contributions!

Check out our [upcoming milestones](https://github.com/material-motion/coreanimation-swift/milestones).

Learn more about [our team](https://material-motion.github.io/material-motion/team/),
[our community](https://material-motion.github.io/material-motion/team/community/), and
our [contributor essentials](https://material-motion.github.io/material-motion/team/essentials/).

## License

Licensed under the Apache 2.0 license. See LICENSE for details.
