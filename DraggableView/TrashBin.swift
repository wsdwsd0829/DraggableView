//
//  TrashBin.swift
//  DraggableView
//
//  Created by sidawang on 2/27/16.
//  Copyright © 2016 sidex. All rights reserved.
//

import UIKit
//like UITableView have UITableDelegate
class TrashBin: UIView, TrashDelegate{
    var garbages = [TrashAble]()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.yellowColor()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.yellowColor()
    }
    
    func animateTrash<T:UIView where T:TrashAble>(trash:T){
            trash.animateToZero()
    }
    
    internal func restoreAll(){
        for (index,garbage) in garbages.enumerate() {
            print("index: \(index) garbage: \(garbage)")
            //?? is it safe to remove object from fast enumeration
            restoreTrash(garbage)
        }
    }
    
    func restoreTrash(let trash:TrashAble){
        self.restoreStatus(trash)
        
        self.restoreAnimation(trash)
        
        self.restoreGarbagesList(trash)
    }
    private func restoreStatus(var trash:TrashAble){
        trash.status = .Alive
    }
    private func restoreAnimation(let trash:TrashAble){
        guard garbages.count > 0 else { return }
        //not used just showOff syntax
        let garbageViews:[UIView] = (garbages.flatMap({
            ($0 as? UIView)
        }))
        //TODO: if is WSDDraggableView (indicate have recover state) then to recover state
        //else just view recover to default state. e.g. CGPointZero
//        for garbageView in garbageViews where garbageView is WSDDraggableView{
//            let wsdGarbageView = garbageView as! WSDDraggableView
//            UIView.animateWithDuration(1, animations: { () -> Void in
//                if wsdGarbageView.recoverRect != nil {
//                    wsdGarbageView.frame = wsdGarbageView.recoverRect!
//                }
//            })
//        }
        let wsdGarbageView = trash as! WSDDraggableView
        UIView.animateWithDuration(1, animations: { () -> Void in
            if wsdGarbageView.recoverRect != nil {
                wsdGarbageView.frame = wsdGarbageView.recoverRect!
            }
        })
        
    }
    private func restoreGarbagesList(let trash:TrashAble){
        guard garbages.count > 0 else{ return }
        //cannot compare trashable itself.
        let findIndex = garbages.indexOf {
            let trashConcrete = $0 as? UIView
            let trashPassedIn = trash as? UIView
            return trashConcrete == trashPassedIn
        }
        if findIndex != nil {
            garbages.removeAtIndex(findIndex!)
        }
    }
    
    

    //grash Delegate
    func trash<T:TrashAble>(var trash:T){
        trash.status = .Trashed
        self.garbages.append(trash)
    }
}
