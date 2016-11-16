# 2.0.0

## Breaking changes

- A Tween with a null to value and non-null from value is no longer supported.

## New features

Tweens can now be scrubbed along a Timeline using the optional `timeline` property.

```
// To associate a timeline with a tween:
tween.timeline = timeline

// To scrub the associated tweens:
timeline.scrubber?.timeOffset = 0.1
```

Tween API now supports an arbitrary number of values. The old from/to APIs have been deprecated.

## Source changes

* [Remove UIView support from Tween performer.](https://github.com/material-motion/coreanimation-swift/commit/0a5a4ca70e9cac341487534e6d5967f2d4b4fff3) (Jeff Verkoeyen)
* [Convert from absolute time to local time.](https://github.com/material-motion/coreanimation-swift/commit/d9eaa540ae4648e77e81f139e97ba3e020ee8473) (Jeff Verkoeyen)
* [Add timeline property to Tween.](https://github.com/material-motion/coreanimation-swift/commit/0978987e5d996d4580ff32e2212e789d7b8a1f15) (Jeff Verkoeyen)
* [Drop Family suffix and update naming throughout the repo.](https://github.com/material-motion/coreanimation-swift/commit/d8eb169d2ab4e29a63ff89ae47942524069da818) (Jeff Verkoeyen)
* [Ensure that we still support from/to/timingFunction with the new APIs.](https://github.com/material-motion/coreanimation-swift/commit/edb1c5bd80c916ce3809e4140172979bbf1c5d58) (Jeff Verkoeyen)
* [Add a recommendation to the timingFunction deprecation message.](https://github.com/material-motion/coreanimation-swift/commit/5bf40939bfef9822d24a7811a942f71a41741bc5) (Jeff Verkoeyen)
* [Implement new keyframe-based Tween API.](https://github.com/material-motion/coreanimation-swift/commit/6200e00fd4cc2fc1a684ea740087444145022f8a) (Jeff Verkoeyen)

## API changes

### Tween

*new* method: `commitFirstValue(to:)` in `Tween`

*new* method: `commitLastValue(to:)` in `Tween`

*new* var: `values` in `Tween`

*new* var: `timingFunctions` in `Tween`

*new* var: `timeline` in `Tween`

*new* var: `keyPositions` in `Tween`

*new* method: `init(_:duration:values:)` in `Tween`

*deprecated* method: `commitFromValue(to:)` in `Tween`

*deprecated* method: `commitToValue(to:)` in `Tween`

*deprecated* method: `init(_:duration:)` in `Tween`

*deprecated* var: `from` in `Tween`

*deprecated* var: `to` in `Tween`

*deprecated* var: `timingFunction` in `Tween`

## Non-source changes

* [Automatic changelog preparation for release.](https://github.com/material-motion/coreanimation-swift/commit/78bd1a249f36e8001611c44d4c466451df05df4b) (Jeff Verkoeyen)
* [Update Runtime dependeny to v6.](https://github.com/material-motion/coreanimation-swift/commit/9fb3ff3029343f29b55a642b0b0bc35e3536ba1d) (Jeff Verkoeyen)
* [Add callsign.](https://github.com/material-motion/coreanimation-swift/commit/5c1d17271914b5b5dead44b9b70a7dcf05230e79) (Jeff Verkoeyen)
* [Update README.md with new values API.](https://github.com/material-motion/coreanimation-swift/commit/c4079f65ad1dca1b2d240c6f2835cbe4ce0cdfa9) (Jeff Verkoeyen)
* [Update README.md](https://github.com/material-motion/coreanimation-swift/commit/e51953f5f249c67889e7571d04452d76a7dd905e) (featherless)

# 1.1.0

This release adds support for Runtime v5.

## Source changes

* [Revert "Implement KeyframeTween."](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/b04b40b4f335e08e9a388c322cd422aacbeca94b) (Jeff Verkoeyen)
* [Add support for Runtime v5.0.0.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/e2818cf0d02fa7e49a023d0fd5c365a02a804ae7) (Jeff Verkoeyen)
* [Implement KeyframeTween.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/38254f4b7e6c3e1a0a0fd77a3323149e9cb1bbc0) (Jeff Verkoeyen)

## Non-source changes

* [Automatic changelog preparation for release.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/6f21da787527e78eff0889735e7e598cb1ed7148) (Jeff Verkoeyen)
* [Update Podfile.lock with latest CocoaPods version.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/46bde21ed70d62fcbb07df916fe8ccd4191ec0fb) (Jeff Verkoeyen)

# 1.0.0

Initial release.

## Source changes

* [Change type from/to to AnyObject? to more clearly reflect their intended use as Objective-C objects.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/a45ade898e14e8603eb39265c59d8897ea77db4a) (Jeff Verkoeyen)
* [Update Runtime dependency to v4 and resolve breakages/deprecations.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/ba69c6765ca52e7873ea13f30888068e7853e00d) (Jeff Verkoeyen)
* [Introduce Tween commit helper methods for committing Tween properties to the model layer.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/2abae29c265a78e0e0308fde63af5ced4760f225) (Jeff Verkoeyen)
* [Refactor catalog project to match standards.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/dd65817e5f3691d244cbff1e8be164f661ab104f) (Jeff Verkoeyen)
* [Remove CAAnimation-as-plan support.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/ed7b0e58bd0b71c6a9e17285065247c20aaf0ecc) (Jeff Verkoeyen)
* [Implement Tween plan + unit test](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/0f2a0381e824f9e759a12c9b20fe98c6016a11d8) (Jeff Verkoeyen)
* [Move CAAnimation performer code to private/ sub-directory.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/9300ad64cc339228bdcbb6ef83a4c730908a5b46) (Jeff Verkoeyen)
* [Resolve Runtime v3 build warnings and remove reference to Runtime's develop branch.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/c69478d504cf5fdfbdff3b5c22d91b312c795a5a) (Jeff Verkoeyen)
* [Xcode 8 GM build fixes.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/cb5f83854db058b1a70ba2fc520c7e495569eab7) (Jeff Verkoeyen)
* [Xcode 8 beta 6 build error fixes.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/7bc5169f9eb85769a4ff3f2a71c0c9c12f493e5c) (Jeff Verkoeyen)
* [Update Podfile dependencies.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/b4a3012bed37e4bfb594cb81a65cc06c174feb32) (Jeff Verkoeyen)
* [Update Runtime dependency and resolve build errors.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/101a41afabc6359b03e2c0318007d57da583d469) (Jeff Verkoeyen)
* [Add initial code and unit tests.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/23d97989764630ae22055e1649a6b75f72a476a5) (Jeff Verkoeyen)

## API changes

Auto-generated by running:

    apidiff 99fdffa05e14a9803d79d000468bca8ef367fcc3 6112242ca637580ff8af376ea392675cd8618234 swift MaterialMotionCoreAnimationFamily.xcworkspace MaterialMotionCoreAnimationFamily

## Tween

*new* method: `commitToValue(to:)` in `Tween`

*new* var: `from` in `Tween`

*new* var: `timingFunction` in `Tween`

*new* var: `duration` in `Tween`

*new* method: `init(_:duration:)` in `Tween`

*new* method: `commitFromValue(to:)` in `Tween`

*new* method: `performerClass()` in `Tween`

*new* class: `Tween`

*new* var: `delay` in `Tween`

*new* var: `to` in `Tween`

*new* method: `copy(with:)` in `Tween`

*new* var: `keyPath` in `Tween`

## Non-source changes

* [Automatic changelog preparation for release.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/6112242ca637580ff8af376ea392675cd8618234) (Jeff Verkoeyen)
* [Add .swift-version file for cocoapods support.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/8406db3f094ff66ce3b99239ecf9476f97d7d612) (Jeff Verkoeyen)
* [Flesh out the README.md with multiple how to's and a features overview.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/a2973ff063d5a9f1986ae03557071e49edba85ee) (Jeff Verkoeyen)
* [Update Podfile.lock.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/81ecff5653fa60b4329532ec34adb0c5c40c708a) (Jeff Verkoeyen)
* [Ran yo mm-github on the repo.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/3d53d62ac646886af6118cf5780120bb929af63d) (Jeff Verkoeyen)
* [Use CatalogByConvention to organize the catalog application.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/be727d7c5dbafb6893afffe61eb350bf4bcff748) (Jeff Verkoeyen)
* [Update repo when running pod install.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/d78f5327bfd958e700b81b10b5bb7466032ea7c1) (Jeff Verkoeyen)
* [Lock Runtime dependency to v3 release.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/22a39c23c486509561c85ab58ef1865c88947bfa) (Jeff Verkoeyen)
* [Update runtime to latest SHA.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/9e97c780f278a7f40ae2a17e394f5ea6ec1cd875) (Jeff Verkoeyen)
* [Add codecov.yml configuration ignoring examples source.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/32afdc45ff38ff450d2d84ec34637adc115a024e) (Jeff Verkoeyen)
* [New Swift syntax and podfile update](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/9ed11bce8962017993cbc6567da1f99274212abb) (Max Luzuriaga)
* [Added example showing some CoreAnimation properties animating](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/a6d9d828a150b23e4bb922519df24c79c6e43514) (Max Luzuriaga)
* [Use https urls for Podfile dependencies.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/5a035fa8b218684688be408a6ce1e9e5856abfc0) (Jeff Verkoeyen)
* [Ran yo mm-github.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/17dd08096f9cad7e302ac94d5aee5be76e853665) (Jeff Verkoeyen)
* [Clone material-arc-tools in travis builds.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/ed23a1ea209c444ecc082527d02efed67f345e03) (Jeff Verkoeyen)
* [Automated large-scaled change: removed all submodules.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/99b04d3c106114e9aff6245cd7d7598f4ac8209b) (Jeff Verkoeyen)
* [[automated lsc] Add --trace to arc unit invocation for travis builds.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/fb3139d84fc844302440392181d7b76bfd5d1403) (Jeff Verkoeyen)
* [Resolve xcodebuild hang caused by uppercase S in "iPhone 6S".](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/7b6a6945568f138476e4df58f7b73f945750f6ae) (Jeff Verkoeyen)
* [Add travis badge to README.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/e4a74095bba32c8c6b8187e6f742479f872494dc) (Jeff Verkoeyen)
* [Ran yo mm-github.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/db0d402a4a24ce59fbe0d4b8490299a574d31b86) (Jeff Verkoeyen)
* [Add missing proselint gitmodule entry.](https://github.com/material-motion/material-motion-family-coreanimation-swift/commit/fc835f612ab758939fcd088b2b39c30aaa8460b4) (Jeff Verkoeyen)
