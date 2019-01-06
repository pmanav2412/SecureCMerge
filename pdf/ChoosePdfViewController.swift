//
//  ChoosePdfViewController.swift
//  pdf
//
//  Created by yana on 11/16/18.
//  Copyright © 2018 yana. All rights reserved.
//

import UIKit


class ChoosePdfViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pdf1(_ sender: UIButton) {
        performSegue(withIdentifier: "Segue1", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
