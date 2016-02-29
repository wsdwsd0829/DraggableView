//
//  WSDDraggableView.swift
//  DraggableView
//
//  Created by sidawang on 2/27/16.
//  Copyright © 2016 sidex. All rights reserved.
//

import UIKit

public class WSDDraggableView: UILabel, Draggable, TrashAble{
    var dragGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer()
    var status = ExistStatus.Alive
    var trashDelegate:TrashDelegate?
    
    var recoverRect:CGRect?
    
    public var isOverFlow:Bool = false;
    convenience init(frame:CGRect, trashDelegate:TrashDelegate?){
        self.init(frame:frame)
        self.trashDelegate = trashDelegate
    }
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        //must enable this for UILabel
        self.userInteractionEnabled = true;
        dragGestureRecognizer.addTarget(self, action: Selector(
            "panAction:"))
        self.addGestureRecognizer(dragGestureRecognizer)
        
        self.recoverRect = frame
        self.text = "defalut title"
        self.textColor = UIColor.grayColor()
        self.backgroundColor = UIColor.blueColor()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    
    
    @IBAction func panAction(panRecognizer:UIPanGestureRecognizer){
        let translation = panRecognizer.translationInView(self.superview)
        if isOverFlow {
            self.center.x += translation.x
            self.center.y += translation.y
        }else{
           self.center.x = clip(self.center.x+translation.x, min:self.frame.width/2.0, max: UIScreen.mainScreen().bounds.width-self.frame.width/2.0)
           self.center.y = clip(self.center.y+translation.y, min:self.frame.height/2.0, max:UIScreen.mainScreen().bounds.height - self.frame.width/2.0)
            
        }
        //prevent cumulate of translation overtime
        panRecognizer.setTranslation(CGPoint(x: 0,y: 0), inView: self.superview)
        
        //detect if trash the view on release
       // guard self is TrashAble else { return }
        if panRecognizer.state == .Ended {
            doTrashing()
        }
    }
    func doTrashing(){
        trashDelegate?.trash(self)
        if let trashBin = trashDelegate as? TrashBin{
            if CGRectIntersectsRect(self.frame, trashBin.frame) {
                trashBin.animateTrash(self)
            }
        }
    }
    
    //helper method
    public func clip<T:protocol<Comparable, Equatable>>(var toClip:T, min:T, max:T)->T{
        if toClip < min {
            toClip = min
        }
        if toClip > max {
            toClip = max
        }
        return toClip
    }
}

