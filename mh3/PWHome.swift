import Foundation
import UIKit
import HomeKit

class PWHomeView : UIViewController, HMHomeManagerDelegate {
    var homeManager = HMHomeManager()
    var currentHome : HMHome!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.homeManager.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //[self updateSelectedHome:nil];
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // [self registerForHomeChangedNotifications];
    }
    /*
    func dealloc() {
        // [self unregisterForHomeChangedNotifications];
    }
    */
    /*
    func homeManager() -> HMHomeManager {
        //return [HomeStore sharedStore].homeManager;
    }
    */

    func registerForHomeChangedNotifications() {
        // NSNotificationCenter.addObserver(self, selector: "homeStoreDidUpdateSharedHome", name: "HomeStoreDidChangeSharedHomeNotification", object: [HomeStore sharedStore])
    }
    
    func unregisterForHomeChangedNotifications() {
        //NSNotificationCenter.removeObserver(self)
    }
    
    func updateSelectedHome (selectedHome: HMHome) {
        self.currentHome = selectedHome
        //[HomeStore sharedStore].home = selectedHome;
    }

}

class HomeStore : NSObject, HMHomeManagerDelegate {
    var home : HMHome!
    var homeManager = HMHomeManager()
    var homeQueue : dispatch_queue_t
    
    override  init() {
        //self = super.init()
        //if !self { return nil }
        homeManager = HMHomeManager()
        //self.homeManager.delegate = self
        homeQueue = dispatch_queue_create("com.sample.HMCatalog.HomeQueue", DISPATCH_QUEUE_SERIAL)
        //return self
    }
    class func sharedStore() {
        
        var token: dispatch_once_t = 0
        dispatch_once(&token) { () -> Void in
            print("Called once")
        }
        
        
        //static
        var sharedInstance : AnyObject! = nil
        //static
        var onceToken : dispatch_once_t = 0
        
        var dbt : dispatch_block_t
        
        
        
        dispatch_once(&onceToken) { () -> Void in
           // sharedInstance = self.new() // .new()
        }// <#T##block: dispatch_block_t##dispatch_block_t##() -> Void#>) (<#T##predicate: UnsafeMutablePointer<dispatch_once_t>##UnsafeMutablePointer<dispatch_once_t>#>, <#T##block: dispatch_block_t##dispatch_block_t##() -> Void#>) (onceToken, dbt)
        
       // var dbt : dispatch_block_t = { sharedInstance = self.new() }
        
   //  dispatch_once(&dispatch_once_t(), dbt)
        //(&onceToken, ^{
    //_sharedInstance = [self new];
    //});
    
   // return sharedInstance;
    }
    
}