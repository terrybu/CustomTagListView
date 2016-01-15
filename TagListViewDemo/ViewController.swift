//
//  ViewController.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TagListViewDelegate {

    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var biggerTagListView: TagListView!
    @IBOutlet weak var biggestTagListView: TagListView!
    var closeButton: CloseButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.delegate = self

        let longPressTag = tagListView.addTag("Long Press Tag")
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPressDetected:")
        longPressTag.addGestureRecognizer(longPress)
        
        
        tagListView.addTag("On tap will be removed").onTap = { [weak self] tagView in
            self?.tagListView.removeTagView(tagView)
        }
        
        let tagView = tagListView.addTag("gray")
        tagView.tagBackgroundColor = UIColor.grayColor()
        tagView.onTap = { tagView in
            print("Don’t tap me!")
        }

        
        biggerTagListView.delegate = self
        biggerTagListView.textFont = UIFont.systemFontOfSize(15)
        biggerTagListView.addTag("Inboard")
        biggerTagListView.addTag("Pomotodo")
        biggerTagListView.addTag("Halo Word")
        biggerTagListView.alignment = .Center
        
        biggestTagListView.delegate = self
        biggestTagListView.textFont = UIFont.systemFontOfSize(24)
        biggestTagListView.addTag("all")
        biggestTagListView.addTag("your")
        biggestTagListView.addTag("tag")
        biggestTagListView.addTag("are")
        biggestTagListView.addTag("belong")
        biggestTagListView.addTag("to")
        biggestTagListView.addTag("us")
        biggestTagListView.alignment = .Right
        
        let tagView2 = biggestTagListView.addTag("terry")
        tagView2.tagBackgroundColor = UIColor.lightGrayColor()
        tagView2.tagSelectedBackgroundColor = UIColor.greenColor()
        tagView2.onTap = { tagView2 in
            print("on tap")
        }
    }
    
    func longPressDetected(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            let tagView = gestureRecognizer.view as! TagView
            //        self.tagListView.removeTagView(tagView)
            closeButton = CloseButton()
            closeButton?.setTitle("X", forState: UIControlState.Normal)
            closeButton?.sizeToFit()
            //        closeButton.titleColorForState(UIControlState)
            
            let topRightCornerTagViewPoint = CGPointMake(tagView.bounds.width, tagView.bounds.height)
            let position = tagView.convertPoint(topRightCornerTagViewPoint, toView: self.view)
            closeButton?.center = position
            closeButton?.tagView = tagView
            closeButton?.addTarget(self, action: "closeAction:", forControlEvents: UIControlEvents.TouchUpInside)
            
            view.addSubview(closeButton!)
        }
    }
    
    func closeAction(sender: CloseButton) {
        //UIView animation here to make the button disappear
        //on completion block, you would call removeFromSuperview
        UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.closeButton?.alpha = 0
                sender.tagView!.alpha = 0
            }) { (completed) -> Void in
                self.closeButton?.removeFromSuperview()
                self.closeButton = nil
                
                
                self.tagListView.removeTagView(sender.tagView!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tagPressed(title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title)")
        //        tagView.selected = !tagView.selected
        tagView.changeColorBasedOnTagState()
        print(tagView.tastiiTagMode)
    }
}

