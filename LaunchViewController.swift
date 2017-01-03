//
//  LaunchViewController.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 12/26/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        AssetLoader.load();
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
