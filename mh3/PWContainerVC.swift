import UIKit

enum AngelPosition {
    case nothing, UpLeft, UpRight, DownLeft, DownRight
}

class PWContainerVC: UIViewController, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var centrView: UIView!
    var foundationView: UIView!
    
    var dx : CGFloat = 0.0
    var dy : CGFloat = 0.0
    var oldPoint = CGPoint()
 //   var isEditRoom = true
    var isEditRoom = false
    var editAngelPosition = AngelPosition.nothing
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let widht = self.view.frame.size.width
        let height = self.view.bounds.height
        foundationView = UIView(frame: CGRect(x: widht/6, y: -60, width: widht*2/3, height: height*2/3))
        foundationView.backgroundColor = UIColor.purpleColor()
        foundationView.addSubview(scrollView.subviews[0])
        centerScrollViewContents()
        scrollView.addSubview(foundationView)
        scrollView.delegate = self;
        
        let room1 = PWRoom(name: "room1")
        room1.bounds.origin.x = 300
        room1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapAct:"))
        room1.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: "longPressAct:"))
        foundationView.addSubview(room1)
        
        let room2 = PWRoom(name: "room2")
        room2.layer.borderColor = UIColor.whiteColor().CGColor
        room2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapAct:"))
        room2.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: "longPressAct:"))
        foundationView.addSubview(room2)
    }
    
    func centerScrollViewContents() {
        let scrSize = scrollView.frame.size
        var scFrame = foundationView.frame
        if scFrame.size.width < scrSize.width {
            scFrame.origin.x = (scrSize.width - scFrame.size.width) / 2.0 }
        else { scFrame.origin.x = 0.0 }
        if scFrame.size.height < scrSize.height {
            scFrame.origin.y = (scrSize.height - scFrame.size.height) / 2.0 - 60 }
        else { scFrame.origin.y = -60.0 }
        foundationView.frame = scFrame
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return foundationView
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    
    func tapAct (gesture: UIGestureRecognizer) {
        if !isEditRoom {
            if let roomFrame = (gesture as? UITapGestureRecognizer)?.view?.frame {
                centrView.frame.origin = CGPoint(x: roomFrame.origin.x + roomFrame.width/2, y: roomFrame.origin.y + roomFrame.height/2)
                self.performSegueWithIdentifier("segueAccessoryRoom", sender: self)
            }
        }
        else {
            if let roomFrame = (gesture as? UITapGestureRecognizer)?.view {
                roomFrame.layer.borderColor = (UIColor.blueColor()).CGColor
            }
        }
    }
    
    func longPressAct (gesture: UIGestureRecognizer) {
        if !isEditRoom {
            if let longPressGR = gesture as? UILongPressGestureRecognizer {
                if longPressGR.state == UIGestureRecognizerState.Began {
                    let startPoint = longPressGR.locationInView(self.foundationView)
                    dx = (longPressGR.view?.frame.origin.x)! - startPoint.x
                    dy = (longPressGR.view?.frame.origin.y)! - startPoint.y
                }
                let point = gesture.locationInView(self.foundationView)
                longPressGR.view?.frame.origin = CGPoint(x: point.x + dx, y: point.y + dy)
            }
        }
        else {
            if let longPressGR = gesture as? UILongPressGestureRecognizer {
                if longPressGR.state == UIGestureRecognizerState.Began {
                    let startPoint = longPressGR.locationInView(self.foundationView)
                    if let roomFrame = longPressGR.view?.frame {
                    dx = startPoint.x - roomFrame.origin.x
                    dy = startPoint.y - roomFrame.origin.y
                    if dx >= 0 && dy >= 0 {
                        if dx < roomFrame.width/5 && dy < roomFrame.height/5 {
                            self.editAngelPosition = .UpLeft
                            self.oldPoint = gesture.locationInView(self.foundationView)
                        }
                    else {
                        longPressGR.view?.backgroundColor = UIColor.whiteColor()
                            self.editAngelPosition = .nothing
                        }
                    }
                    }
                }
                if self.editAngelPosition == .UpLeft {
                longPressGR.view?.backgroundColor = UIColor.redColor()
                let point = gesture.locationInView(self.foundationView)
                let frame = CGRect(origin: CGPoint(x: point.x - dx, y: point.y - dy), size: CGSize(width:(longPressGR.view?.frame.size.width)! + oldPoint.x - point.x , height: (longPressGR.view?.frame.size.height)! + oldPoint.y - point.y))
                longPressGR.view?.frame = frame
                    self.oldPoint = gesture.locationInView(self.foundationView)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueAccessoryRoom" {
            if let popoverController = (segue.destinationViewController as! UITableViewController).popoverPresentationController {
                popoverController
                popoverController.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func round (x : Int) -> Int {
//        if x%10 < 5
        return 10
    }
    
}

