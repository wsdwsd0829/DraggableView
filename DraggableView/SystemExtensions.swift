//
//  SystemExtensions.swift
//  DraggableView
//
//  Created by sidawang on 2/28/16.
//  Copyright © 2016 sidex. All rights reserved.
//
import UIKit
extension UIView{
    public func animateToZero(){
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.frame = CGRectMake(self.center.x, self.center.y, 0, 0)
            }) { (result:Bool) -> Void in
                print("finished Animation for trash view")
        }
    }
}