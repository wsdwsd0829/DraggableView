//
//  ViewController.swift
//  DraggableView
//
//  Created by sidawang on 2/27/16.
//  Copyright © 2016 sidex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var trashBin : TrashBin?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        
        setupInitViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setupInitViews(){
        trashBin = TrashBin(frame: CGRectMake(200, 200, 200, 200))
        let dView = WSDDraggableView(frame: CGRectMake(10,100,100,100), trashDelegate: trashBin!)
//        let dView = WSDDraggableView(frame: CGRectMake(10,100,100,100))
//        dView.trashDelegate = trashBin
        dView.text = "Label"
        
        self.view.addSubview(trashBin!)
        self.view.addSubview(dView)
        dView.backgroundColor = UIColor.greenColor()

    }
    @IBAction func addNew(barButton:UIBarButtonItem){
        let newView = WSDDraggableView(frame: CGRectMake(10,100,100,100), trashDelegate:self.trashBin)
        self.view.addSubview(newView)
    }
    
    @IBAction func restore(barButton:UIBarButtonItem){
        trashBin?.restoreAll()
    }
    
    func setupNavigationBarItems(){
        let addNewView = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("addNew:"))
      //cannot change System Item title
        let restoreTrashedViews = UIBarButtonItem(title: "Restore", style:.Plain, target: self, action: Selector("restore:"))
        
        self.navigationItem.title = "trash machine"
        self.navigationItem.leftBarButtonItem = addNewView
        self.navigationItem.rightBarButtonItem = restoreTrashedViews
       
    }
}

