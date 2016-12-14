//
//  TestViewController.swift
//  LZTabBarController-swift
//
//  Created by Artron_LQQ on 2016/12/14.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.cyan
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LZTabBarController.shared.hiddenTabBar(animation: true)
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
