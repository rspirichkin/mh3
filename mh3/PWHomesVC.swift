import UIKit

enum HomeListSection: NSInteger {
    case HomeListSectionHomes = 0,
    HomeListSectionPrimaryHome
}


class PWHomesVC: UITableViewController {
    
    var homeManager = HMHomeManager()
    
    
    func indexPathIsAdd(indexPath: NSIndexPath) -> Bool {
        let sec = indexPath.section
        let ro = indexPath.row
        let raw = HomeListSection.HomeListSectionHomes.rawValue
        let cou = self.homeManager.homes.count
    return indexPath.section == HomeListSection.HomeListSectionHomes.rawValue &&
    indexPath.row == self.homeManager.homes.count;
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        let homes = self.homeManager.homes.count;
        let sec = section
        let u = HomeListSection(rawValue: section)
        let u2 = HomeListSection.RawValue(section)
        let u3 = HomeListSection.HomeListSectionHomes.rawValue
        
        switch HomeListSection.RawValue(section) {
        case HomeListSection.HomeListSectionHomes.rawValue:
            return homes + 1
        case HomeListSection.HomeListSectionPrimaryHome.rawValue:
            return max(homes, 1)
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.indexPathIsAdd(indexPath) {
            return tableView.dequeueReusableCellWithIdentifier("AddHomeCell", forIndexPath: indexPath)
        }
        else if self.homeManager.homes.count == 0 {
            return tableView.dequeueReusableCellWithIdentifier("NoHomesCell", forIndexPath: indexPath)
        }
        
        var reuseIdentifier : String
        switch (indexPath.section) {
        case HomeListSection.HomeListSectionHomes.rawValue:
            reuseIdentifier = "HomeCell"
        case HomeListSection.HomeListSectionPrimaryHome.rawValue:
            reuseIdentifier = "PrimaryHomeCell"
        default :
            reuseIdentifier = ""
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        let home = self.homeManager.homes[indexPath.row]
        cell.textLabel!.text = home.name
        
        if indexPath.section == HomeListSection.HomeListSectionPrimaryHome.rawValue {
            if (home == self.homeManager.primaryHome) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None;
            }
        }
    return cell
    
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var couG = self.homeManager.homes.count
        
        for i in 0..<self.homeManager.homes.count {
            self.homeManager.removeHome(self.homeManager.homes[i], completionHandler: {
                (error: NSError?) ->  Void in
                if (error != nil) {
                } // Failed to add a home
                else {
                } // Successfully added a home
            })
        }
        
        couG = self.homeManager.homes.count
        self.homeManager.addHomeWithName("h1", completionHandler: {
            (home: HMHome?, error: NSError?) ->  Void in
            if (error == nil) {
                var cou = self.homeManager.homes.count
                for i in self.homeManager.homes {
                    self.homeManager.removeHome(i, completionHandler: {
                        (error: NSError?) ->  Void in
                        if (error != nil) {
                        } // Failed to add a home
                        else {
                        } // Successfully added a home
                    })
                }
                var cou2 = self.homeManager.homes.count
                
                var er = 1
            } // Failed to add a home
            else {
                
                var cou = self.homeManager.homes.count
                var er = 1
            } // Successfully added a home
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

