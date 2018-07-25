//
//  ViewController.swift
//  CustomScrollView
//
//  Created by Param Aggarwal on 25/07/18.
//  Copyright © 2018 Param Aggarwal. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var customScrollView: MyScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customScrollView = MyScrollView(frame: self.view.bounds)
        self.customScrollView!.contentSize = CGSize(width: self.view.bounds.size.width+500, height: 1000)
//        self.customScrollView!.scrollHorizontal = false
//        self.customScrollView!.scrollVertical = false
        
        let redView = UIView(frame:CGRect(x: 20, y: 20, width: 100, height: 100))
        let greenView = UIView(frame:CGRect(x: 150, y: 160, width: 150, height: 200))
        let blueView = UIView(frame:CGRect(x: 40, y: 400, width: 200, height: 150))
        let yellowView = UIView(frame:CGRect(x: 100, y: 600, width: 180, height: 150))
        
        redView.backgroundColor = UIColor(red: 0.815, green: 0.007, blue: 0.105, alpha: 1)
        greenView.backgroundColor = UIColor(red: 0.494, green: 0.827, blue: 0.129, alpha: 1)
        blueView.backgroundColor = UIColor(red: 0.29, green: 0.564, blue: 0.886, alpha: 1)
        yellowView.backgroundColor = UIColor(red: 0.972, green: 0.905, blue: 0.109, alpha: 1)
        
        self.customScrollView!.addSubview(redView)
        self.customScrollView!.addSubview(greenView)
        self.customScrollView!.addSubview(blueView)
        self.customScrollView!.addSubview(yellowView)
        
        let redViewClone = UIView(frame:CGRect(x: 300+20, y: 20, width: 100, height: 100))
        let greenViewClone = UIView(frame:CGRect(x: 300+150, y: 160, width: 150, height: 200))
        let blueViewClone = UIView(frame:CGRect(x: 300+40, y: 400, width: 200, height: 150))
        let yellowViewClone = UIView(frame:CGRect(x: 300+100, y: 600, width: 180, height: 150))
        
        redViewClone.backgroundColor = UIColor.purple
        greenViewClone.backgroundColor = UIColor.red
        blueViewClone.backgroundColor = UIColor.gray
        yellowViewClone.backgroundColor = UIColor.black
        
        self.customScrollView!.addSubview(redViewClone)
        self.customScrollView!.addSubview(greenViewClone)
        self.customScrollView!.addSubview(blueViewClone)
        self.customScrollView!.addSubview(yellowViewClone)
        
        self.view.addSubview(self.customScrollView!);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

