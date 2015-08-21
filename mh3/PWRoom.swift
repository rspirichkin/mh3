//
//  PWRoom.swift
//  mh3
//
//  Created by Roman Spirichkin on 8/18/15.
//  Copyright © 2015 Perfect Ware Development. All rights reserved.
//

import UIKit

class PWRoom : UIView {
    var name : String
    var x : CGFloat = 200
    var y : CGFloat = 200
    var width : CGFloat  = 100
    var height : CGFloat = 100
    
    init(name: String) {
        self.name = name
        super.init(frame: CGRectMake(x, y, width, height))
        self.backgroundColor = UIColor.blackColor()
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rect() -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }

}