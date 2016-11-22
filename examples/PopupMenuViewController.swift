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

  let runtime = Runtime()

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

  func handleTap(gestureRecognizer: UIGestureRecognizer) {
    let bounceTimingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.6, 1, 1)

    runtime.tween(withDuration: animDuration, timingFunction: bounceTimingFunction) {
      mainBtn!.layer.transform = buttonsShowing ? CATransform3DIdentity : CATransform3DMakeScale(0.6, 0.6, 1.0)
      mainBtn!.layer.shadowRadius = buttonsShowing ? 5 : 2
      mainBtn!.backgroundColor = buttonsShowing ? .orange : .lightGray

      additionalBtn1!.opacity = buttonsShowing ? 0 : 1
      additionalBtn2!.opacity = buttonsShowing ? 0 : 1
      additionalBtn3!.opacity = buttonsShowing ? 0 : 1

      let radialButtons = [
        (additionalBtn1!, angle1),
        (additionalBtn2!, angle2),
        (additionalBtn3!, angle3)
      ]
      let position = mainBtn!.layer.position
      for pair in radialButtons {
        pair.0.position = buttonsShowing
          ? position
          : CGPoint(x: position.x - CGFloat(sinf(pair.1)) * distFromMainButton,
                    y: position.y - CGFloat(cosf(pair.1)) * distFromMainButton)
      }
    }

    buttonsShowing = !buttonsShowing
  }
}
