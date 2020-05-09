import UIKit

class ViewController: UIViewController {
    var lastCGPoint: CGPoint?; let DotColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let position = touch.location(in: view)
        if let lastCGPoint = self.lastCGPoint {
            self.drawLineFromPoint(start: lastCGPoint, toPoint: position, ofColor: DotColor, inView: self.view!)
        }
        self.lastCGPoint = position
        view!.addSubview(Dot(pos: position))
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let position = touch.location(in: view)
        self.lastCGPoint = position
        view!.addSubview(Dot(pos: position))
        }
    }

    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.removeFromSuperlayer()
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.20
        shapeLayer.add(animation, forKey: "AnimationLine")
    }
    
    func Dot(pos: CGPoint) -> UIView {
        let dot = UIView(frame: CGRect(x: pos.x, y: pos.y, width: 15, height: 15))
        dot.backgroundColor = DotColor
        dot.layer.cornerRadius = dot.frame.width / 2
        return dot
    }
}
