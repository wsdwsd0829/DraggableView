//
//  CustomProtocols.swift
//  DraggableView
//
//  Created by sidawang on 2/27/16.
//  Copyright © 2016 sidex. All rights reserved.
//

import Foundation
import UIKit

enum ExistStatus{
    case Alive
    case Trashed
}

protocol Draggable{
    var dragGestureRecognizer:UIPanGestureRecognizer{get}
}

protocol TrashAble{
    var status:ExistStatus{get set}
}

protocol TrashDelegate{
    //a data souce for all trashed items
    var garbages:[TrashAble]{get set}

    //this function should trash the object status and return a bool indicate if process success or not
    //TODO: throw exception if not trashable.
    func trash<T:TrashAble>(var trash:T)
    //optional func trashAnimate<T: UIView where T:Trashable>(var trash:T)
}