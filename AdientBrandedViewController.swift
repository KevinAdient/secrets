//
//  AdientBrandedViewController.swift
//  SQRA
//
//  Created by Peter Gits on 10/26/16.
//  Copyright © 2016 Mobility. All rights reserved.
//

import Foundation
import UIKit

class AdientBrandedViewController: UIViewController {
    
    
    @IBOutlet var brandedView: AdientSeatBrandedCustomView!

    @IBOutlet weak var NextBrandingButton: UIButton!
    @IBOutlet weak var ReplayBrandingButton: UIButton!
    var iReturningForMore:Int = 0
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        self.brandedView.frame = self.view.frame
        self.NextBrandingButton.isHidden = true
        print(self.brandedView)
        self.brandedView.addAdientBrandingAnimation(completionBlock: {
            (true) -> Void in
            self.NextBrandingButton.isHidden = false
            self.NextBrandingButton.sendActions(for: .touchUpInside)
            }
        )
    }
    @IBAction func ReplayButtonHit(_ sender: Any) {
        //self.brandedView.removeAllAnimations()
        //self.brandedView.frame = self.view.frame
        self.NextBrandingButton.isHidden = true
        self.brandedView.setNeedsDisplay()
        self.brandedView.addAdientBrandingAnimation(completionBlock: {
            (true) -> Void in
            self.NextBrandingButton.isHidden = false
        }
        )
    }
    
    @IBAction func animate(_ _sender:AnyObject){
        self.brandedView.addAdientBrandingAnimation()
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool){
        iReturningForMore += 1
        if(iReturningForMore > 1){
            //every other time
            self.brandedView.addAdientBrandingAnimation(completionBlock: {
                (true) -> Void in
                self.NextBrandingButton.isHidden = false
            }
            )
            self.NextBrandingButton.isHidden = false
            self.ReplayBrandingButton.isHidden = false
        }
        else {
            //first time thru
            self.NextBrandingButton.isHidden = false
            self.ReplayBrandingButton.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Storyboard Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        //var nextScene =  segue.destination as! LoginViewController
    
    }
    
}
