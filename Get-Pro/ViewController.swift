//
//  ViewController.swift
//  Get-Pro
//
//  Created by Yotam Bloom on 7/3/17.
//  Copyright © 2017 Yotam Bloom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var lunchTimer: Timer!

    override func viewWillAppear(_ animated: Bool) {
        lunchTimer = Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)

        //load data
        
        //check for registration
        let when = DispatchTime.now() + 4.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.lunchTimer.invalidate()
            self.progressBar.progress = 0.95
            
            if AppManager.login() {
                //navigate to menu
                self.performSegue(withIdentifier: "menuSeg", sender: self)

            }
            else{
                //navigate to register
                self.performSegue(withIdentifier: "registerSeg", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func runTimedCode() {
        if self.progressBar.progress < 0.7 {
            self.progressBar.progress += 0.05
        }
    }


}

