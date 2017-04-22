//
//  MainMenuViewController.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 12/25/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Assets.loadGameAssets()        
    }
}
