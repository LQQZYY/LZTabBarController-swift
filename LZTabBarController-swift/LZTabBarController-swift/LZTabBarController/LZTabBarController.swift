//
//  LZTabBarController.swift
//  LZTabBarController-swift
//
//  Created by Artron_LQQ on 2016/12/14.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

let lzTabBarHeight: CGFloat = 49.0

class LZTabBarController: UITabBarController, LZTabBarDelegate {

    var config: LZTabBarConfig!
    private lazy var customTabBar: LZTabBar = {
        
        let tab = LZTabBar()
        tab.delegate = self
        
        return tab
    }()
    
    static var shared: LZTabBarController = {
        
        let tab = LZTabBarController()
        
        return tab
    }()
    
    func hiddenTabBar(animation: Bool) {
        
        if animation {
            UIView.animate(withDuration: 0.4, animations: {
                
                self.customTabBar.alpha = 0
            })
        } else {
            
            self.customTabBar.alpha = 0
        }
    }
    
    func showTabBar(animation: Bool) {
        
        if animation {
            UIView.animate(withDuration: 0.4, animations: { 
                
                self.customTabBar.alpha = 1
            })
        } else {
            self.customTabBar.alpha = 1
        }
    }
    
    private init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func configSources(_ block: ((LZTabBarConfig) -> LZTabBarConfig)) {
        
        let conf = LZTabBarConfig()
        
        self.config = block(conf)
        
        self.setupControllers()
        self.setupTabBar()
    }
    
    private func setupControllers() {
        
        guard let tempVcs = self.config.viewControllers else {
            
            assertionFailure("Param 'viewControllers' in the 'config' can not be nil")
            return
        }
        
        if self.config.isNavigation {
            
            var vcs: Array<UIViewController> = []
            
            for item in tempVcs {
                
                if item is UINavigationController {
                    
                    vcs.append(item)
                } else {
                    
                    let nav = UINavigationController(rootViewController: item)
                    vcs.append(nav)
                }
            }
            
            self.viewControllers = vcs
        } else {
            
            self.viewControllers = tempVcs
        }
    }
    
    private func setupTabBar() {
        
        var index: Int = 0
        var items: Array<LZTabBarItem> = []
        
        var style: LZTabBarItemStyle = .normal
        
        if (self.config.selectedImages != nil || self.config.normalImages != nil) && self.config.titles != nil {
            
            style = .normal
        } else if (self.config.selectedImages != nil || self.config.normalImages != nil) && self.config.titles == nil {
            
            style = .image
        } else if (self.config.selectedImages == nil && self.config.normalImages == nil) && self.config.titles != nil {
            
            style = .text
        }
        
        for _ in self.config.viewControllers! {
            
            let item = LZTabBarItem()
            
            item.style = style
            
            if index == 0 {
                
                if let images = self.config.selectedImages {
                    
                    item.icon = images[index]
                }
                
                if let _ = self.config.titles {
                    item.titleColor = self.config.selectedColor
                }
            } else {
                
                if let images = self.config.normalImages {
                    
                    item.icon = images[index]
                    
                    if let _ = self.config.titles {
                        item.titleColor = self.config.normalColor
                    }
                }
            }
            
            if index < (self.config.titles?.count)! {
                
                item.title = self.config.titles?[index]
            }
            
            items.append(item)
            item.index = index
            
            index += 1
        }
        
        self.tabBar.isHidden = true
        
        self.customTabBar.items = items
        self.customTabBar.frame = CGRect(x: 0, y: self.view.frame.height - lzTabBarHeight, width: self.view.frame.width, height: lzTabBarHeight)
        
        self.view.addSubview(self.customTabBar)
    }
    
    
    //MARK: - LZTabBarDelegate
    func tabBar(_ bar: LZTabBar, didSelectItem item: LZTabBarItem, atIndex index: Int) {
        
        var items: Array<LZTabBarItem> = []
        for tem in bar.subviews {
            
            if tem is LZTabBarItem {
                items.append(tem as! LZTabBarItem)
            }
        }
        
        var i = 0
        
        for tem in items {
            
            tem.icon = self.config.normalImages?[i]
            if (self.config.titles?.count)! > 0 {
                
                tem.titleColor = self.config.normalColor
            }
            
            i += 1
        }
        
        item.icon = self.config.selectedImages?[index]
        
        if (self.config.titles?.count)! > 0 {
            item.titleColor = self.config.selectedColor
        }
        
        self.selectedIndex = index
    }
    
    //MARK: - 屏幕旋转时调整tabbar
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.customTabBar.frame = CGRect(x: 0, y: size.height - lzTabBarHeight, width: size.width, height: lzTabBarHeight)
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


class LZTabBarConfig {
    
    var viewControllers: Array<UIViewController>?
    var titles: Array<String>?
    var isNavigation: Bool = true
    var selectedImages: Array<String>?
    var normalImages: Array<String>?
    var selectedColor: UIColor? = UIColor.red
    var normalColor: UIColor? = UIColor.gray
}
