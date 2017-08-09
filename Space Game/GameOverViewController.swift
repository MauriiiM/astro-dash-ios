//
//  GameOverViewController.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 12/25/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var hsLabel: UILabel!

    var recievedDistance = ""
    var recievedLevel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        currentScoreLabel.font = UIFont(name: "04b_19", size: <#T##CGFloat#>)
//        currentScoreLabel.text = recievedScore
        
        print("Distance = \(recievedDistance) \t Level = \(recievedLevel)")
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
