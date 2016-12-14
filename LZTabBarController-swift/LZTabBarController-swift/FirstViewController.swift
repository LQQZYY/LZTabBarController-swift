//
//  FirstViewController.swift
//  LZTabBarController-swift
//
//  Created by Artron_LQQ on 2016/12/14.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.green
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let test = TestViewController()
        
        self.navigationController?.pushViewController(test, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LZTabBarController.shared.showTabBar(animation: true)
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
