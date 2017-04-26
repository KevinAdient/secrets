//
//  PromptViewController.swift
//  SAPcontainer
//
//  Created by Peter Michael Gits on 4/26/17.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import UIKit

class PromptViewController: BaseViewController /*UIViewController*/ {

    @IBOutlet weak var buttonSelected: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
