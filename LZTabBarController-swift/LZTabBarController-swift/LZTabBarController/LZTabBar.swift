//
//  LZTabBar.swift
//  LZTabBarController-swift
//
//  Created by Artron_LQQ on 2016/12/14.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

class LZTabBar: UIView, LZTabBarItemDelegate {

    var items: Array<LZTabBarItem> = []
    var delegate: LZTabBarDelegate?
    
    private lazy var effectView: UIVisualEffectView = {
        
        let effect = UIBlurEffect.init(style: UIBlurEffectStyle.light)
        
        let effectVi = UIVisualEffectView(effect: effect)
        
        self.addSubview(effectVi)
        return effectVi
    }()
    
    private lazy var topLine: UIView = {
        
        let line = UIView()
        line.backgroundColor = UIColor.gray
        self.addSubview(line)
        
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.effectView.frame = self.bounds
        
        let width = self.frame.width/CGFloat(self.items.count)
        let height = self.frame.height
        
        var index: CGFloat = 0
        
        for item in self.items {
            
            item.frame = CGRect(x: index*width, y: 0, width: width, height: height)
            
            self.addSubview(item)
            item.delegate = self
            
            index += 1
        }
        
        self.topLine.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 0.6)
    }
    
    func tabBarItem(_ item: LZTabBarItem, didSelectIndex index: Int) {
        
        self.delegate?.tabBar(self, didSelectItem: item, atIndex: index)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

protocol LZTabBarDelegate {
    
    func tabBar(_ bar: LZTabBar, didSelectItem item: LZTabBarItem, atIndex index: Int)
}
