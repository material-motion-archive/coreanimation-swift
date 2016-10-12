# Core Animation Material Motion Family

[![Build Status](https://travis-ci.org/material-motion/material-motion-family-coreanimation-swift.svg?branch=develop)](https://travis-ci.org/material-motion/material-motion-family-coreanimation-swift)
[![codecov](https://codecov.io/gh/material-motion/material-motion-family-coreanimation-swift/branch/develop/graph/badge.svg)](https://codecov.io/gh/material-motion/material-motion-family-coreanimation-swift)

The Core Animation Material Motion family provides a bridge between
[Core Animation](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html) and the
[Material Motion runtime](https://github.com/material-motion/material-motion-runtime-objc).

## Supported languages

- Swift 3
- Objective-C

## Features

`Tween` uses Core Animation's CABasicAnimation to animate a CALayer property along an easing curve.

Use a Tween like you would use a CABasicAnimation instance: provide a key path, duration, and one or
both of the from/to value.

```swift
let tweenBackgroundColor = Tween("backgroundColor", duration: animDuration)
tweenBackgroundColor.from = UIColor.orange.cgColor
tweenBackgroundColor.to = UIColor.lightGray.cgColor
scheduler.addPlan(tweenBackgroundColor, to: myView)
```

Tween's properties map to the following Core Animation properties:

| Tween | Core Animation |
|:-----:|:--------------:|
| delay  | delay |
| duration  | duration |
| from  | fromValue |
| keyPath  | keyPath |
| to  | toValue |
| timingFunction  | timingFunction |

No other Core Animation properties are presently supported. View our filed
[feature requests](https://github.com/material-motion/material-motion-family-coreanimation-swift/labels/Feature%20request)
to track progress on supporting additional functionality.

## Installation

### Installation with CocoaPods

> CocoaPods is a dependency manager for Objective-C and Swift libraries. CocoaPods automates the
> process of using third-party libraries in your projects. See
> [the Getting Started guide](https://guides.cocoapods.org/using/getting-started.html) for more
> information. You can install it with the following command:
>
>     gem install cocoapods

Add `MaterialMotionCoreAnimationFamily` to your `Podfile`:

    pod 'MaterialMotionCoreAnimationFamily'

Then run the following command:

    pod install

### Usage

Import the framework:

    @import MaterialMotionCoreAnimationFamily;

You will now have access to all of the APIs.

## Example apps/unit tests

Check out a local copy of the repo to access the Catalog application by running the following
commands:

    git clone https://github.com/material-motion/material-motion-family-coreanimation-swift.git
    cd material-motion-family-coreanimation-swift
    pod install
    open MaterialMotionCoreAnimationFamily.xcworkspace

## Guides

1. [How to animate a property with a Tween plan](#how-to-animate-a-property-with-a-tween-plan)
2. [How to commit Tween values to a layer](#how-to-commit-tween-values-to-a-layer)

### How to animate a property with a Tween plan

Code snippets:

***In Objective-C:***

```objc
MDMTween *tween = [[MDMTween alloc] initWithKeyPath:@"<#key path#>" duration:<#duration#>];
tween.from = <#from value#>;
tween.to = <#to value#>;
[scheduler addPlan:tween to:<#Object#>];
```

***In Swift:***

```swift
let tween = Tween(<#key path#>, duration: <#duration#>)
tween.from = <#from value#>
tween.to = <#to value#>
scheduler.addPlan(tween, to: <#Object#>)
```

### How to commit Tween values to a layer

We provide two helper APIs for committing the to/from value of a Tween plan to a given CALayer
instance. This is most often used to commit the `to` value of the Tween to the layer so that the
property does not appear to "snap back" upon completion of the animation.

Code snippets:

***In Objective-C:***

```objc
[tween commitToValueTo:<#CALayer#>]
```

***In Swift:***

```swift
tween.commitToValue(to: <#CALayer#>)
```

## Contributing

We welcome contributions!

Check out our [upcoming milestones](https://github.com/material-motion/material-motion-family-coreanimation-swift/milestones).

Learn more about [our team](https://material-motion.gitbooks.io/material-motion-team/content/),
[our community](https://material-motion.gitbooks.io/material-motion-team/content/community/), and
our [contributor essentials](https://material-motion.gitbooks.io/material-motion-team/content/essentials/).

## License

Licensed under the Apache 2.0 license. See LICENSE for details.
