import UIKit


class PWManagerMasterVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func perfomSegueAddNew (sender: AnyObject) {
        self.performSegueWithIdentifier("segueAddNew", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueAddNew" {
            if let popoverController = (segue.destinationViewController as! UITableViewController).popoverPresentationController {
                //popoverController.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

