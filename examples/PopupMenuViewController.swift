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
import MaterialMotionCoreAnimationFamily

let animDuration = 0.2
let distFromMainButton: CGFloat = 100.0
let angle1: Float = Float(M_PI) / 3.0
let angle2: Float = 0
let angle3: Float = -angle1

class PopupMenuViewController: UIViewController {

  var mainBtn: UIView?
  var additionalBtn1: CALayer?
  var additionalBtn2: CALayer?
  var additionalBtn3: CALayer?

  var buttonsShowing: Bool = false

  let scheduler = Scheduler()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = .white

    let width = self.view.frame.width
    let height = self.view.frame.height
    mainBtn = UIView(frame: CGRect(x: width / 2 - 20, y: height - 70, width: 40, height: 40))
    mainBtn?.backgroundColor = .orange
    mainBtn?.layer.cornerRadius = 20
    mainBtn?.layer.shadowColor = UIColor.black.cgColor
    mainBtn?.layer.shadowOffset = CGSize(width: 0, height: 2)
    mainBtn?.layer.shadowOpacity = 0.3
    mainBtn?.layer.shadowRadius = 5
    self.view.addSubview(mainBtn!)

    mainBtn?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:))))

    additionalBtn1 = CALayer()
    additionalBtn1?.bounds = mainBtn!.frame
    additionalBtn1?.position = mainBtn!.layer.position
    additionalBtn1?.cornerRadius = 20
    additionalBtn1?.backgroundColor = UIColor.blue.cgColor
    additionalBtn1?.opacity = 0
    self.view.layer.insertSublayer(additionalBtn1!, below: mainBtn!.layer)

    additionalBtn2 = CALayer()
    additionalBtn2?.bounds = mainBtn!.frame
    additionalBtn2?.position = mainBtn!.layer.position
    additionalBtn2?.cornerRadius = 20
    additionalBtn2?.backgroundColor = UIColor.blue.cgColor
    additionalBtn2?.opacity = 0
    self.view.layer.insertSublayer(additionalBtn2!, below: mainBtn!.layer)

    additionalBtn3 = CALayer()
    additionalBtn3?.bounds = mainBtn!.frame
    additionalBtn3?.position = mainBtn!.layer.position
    additionalBtn3?.cornerRadius = 20
    additionalBtn3?.backgroundColor = UIColor.blue.cgColor
    additionalBtn3?.opacity = 0
    self.view.layer.insertSublayer(additionalBtn3!, below: mainBtn!.layer)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func handleTap(gestureRecognizer: UIGestureRecognizer) {
    let bounceTimingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.6, 1, 1)

    // Make main button smaller
    let smallerBtn = Tween("transform", duration: animDuration)

    let initialTransform = CATransform3DIdentity
    let endTransform = CATransform3DMakeScale(0.6, 0.6, 1.0)

    smallerBtn.from = NSValue(caTransform3D: buttonsShowing ? endTransform : initialTransform)
    smallerBtn.to = NSValue(caTransform3D: buttonsShowing ? initialTransform : endTransform)
    smallerBtn.timingFunction = bounceTimingFunction

    // Main button shadow smaller
    let smallerShadow = Tween("shadowRadius", duration: animDuration)

    let initialRadius = 5
    let endRadius = 2

    smallerShadow.from = NSNumber(value: buttonsShowing ? endRadius : initialRadius)
    smallerShadow.to = NSNumber(value: buttonsShowing ? initialRadius : endRadius)
    smallerShadow.timingFunction = bounceTimingFunction

    // Main button grey
    let greyButton = Tween("backgroundColor", duration: animDuration)

    let initialColor: AnyObject = UIColor.orange.cgColor
    let endColor: AnyObject = UIColor.lightGray.cgColor

    greyButton.from = buttonsShowing ? endColor : initialColor
    greyButton.to = buttonsShowing ? initialColor : endColor

    // Move and fade buttons
    let btn1Move = generateBtnMove(btn: additionalBtn1!, distance: distFromMainButton, angle: angle1, timing: bounceTimingFunction)
    let btn1Fade = generateBtnFade(btn: additionalBtn1!)

    let btn2Move = generateBtnMove(btn: additionalBtn2!, distance: distFromMainButton, angle: angle2, timing: bounceTimingFunction)
    let btn2Fade = generateBtnFade(btn: additionalBtn2!)

    let btn3Move = generateBtnMove(btn: additionalBtn3!, distance: distFromMainButton, angle: angle3, timing: bounceTimingFunction)
    let btn3Fade = generateBtnFade(btn: additionalBtn3!)

    func addAndCommit(tween: Tween, to target: CALayer) {
      scheduler.addPlan(tween, to: target)
      tween.commitToValue(to: target)
    }
    addAndCommit(tween: smallerBtn, to: mainBtn!.layer)
    addAndCommit(tween: greyButton, to: mainBtn!.layer)
    addAndCommit(tween: smallerShadow, to: mainBtn!.layer)
    addAndCommit(tween: btn1Move, to: additionalBtn1!)
    addAndCommit(tween: btn1Fade, to: additionalBtn1!)
    addAndCommit(tween: btn2Move, to: additionalBtn2!)
    addAndCommit(tween: btn2Fade, to: additionalBtn2!)
    addAndCommit(tween: btn3Move, to: additionalBtn3!)
    addAndCommit(tween: btn3Fade, to: additionalBtn3!)

    buttonsShowing = !buttonsShowing
  }

  func generateBtnMove(btn: CALayer, distance: CGFloat, angle: Float, timing: CAMediaTimingFunction) -> Tween {
    let move = Tween("position", duration: animDuration)
    let initialPos = mainBtn!.layer.position

    let x = initialPos.x - CGFloat(sinf(angle)) * distance
    let y = initialPos.y - CGFloat(cosf(angle)) * distance
    let endPos = CGPoint(x: x, y: y)

    move.from = NSValue(cgPoint: buttonsShowing ? endPos : initialPos)
    move.to = NSValue(cgPoint: buttonsShowing ? initialPos : endPos)
    move.timingFunction = timing

    return move
  }

  func generateBtnFade(btn: CALayer) -> Tween {
    let fade = Tween("opacity", duration: animDuration)

    let initialOpacity = NSNumber(value: 0.0)
    let endOpacity = NSNumber(value: 1.0)

    fade.from = buttonsShowing ? endOpacity : initialOpacity
    fade.to = buttonsShowing ? initialOpacity : endOpacity

    return fade
  }
}
