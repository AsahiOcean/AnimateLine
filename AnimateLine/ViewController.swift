import UIKit

class ViewController: UIViewController {
    var lastCGPoint: CGPoint?
    var DotColor = UIColor.black
    var LineWidth: Float = 3

    @IBOutlet weak var CollectionColor: UICollectionView!
    // SliderLineWidth
    @IBOutlet weak var SliderLineWidth: UISlider! {
        didSet{
            SliderLineWidth.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi*1.5))
            SliderLineWidth.layer.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - CollectionColor.frame.height * 4, width: SliderLineWidth.frame.width, height: 200)
        }
    }
    @IBAction func ChangeLineWidth(_ sender: UISlider) {
        self.LineWidth = sender.value
    }
        
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

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { if let touch = touches.first {
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
        shapeLayer.strokeColor = self.DotColor.cgColor
        shapeLayer.lineWidth = CGFloat(self.LineWidth)
        shapeLayer.path = path.cgPath
        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.20
        shapeLayer.add(animation, forKey: "AnimationLine")
    }
    
    func Dot(pos: CGPoint) -> UIView {
        let dot = UIView(frame: CGRect(x: pos.x, y: pos.y, width: 15, height: 15))
        dot.backgroundColor = self.DotColor
        dot.layer.cornerRadius = dot.frame.width / 2
        return dot
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCell
        cell.backgroundColor = Colors[indexPath.row]
        cell.layer.cornerRadius = cell.frame.width / 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.DotColor = Colors[indexPath.row]
    }
}
