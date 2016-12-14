//
//  LZTabBarItem.swift
//  LZTabBarController-swift
//
//  Created by Artron_LQQ on 2016/12/14.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

let defaultTag: Int = 10000
enum LZTabBarItemStyle {
    
    case normal
    case image
    case text
}

class LZTabBarItem: UIView {

    var delegate: LZTabBarItemDelegate?
    var style: LZTabBarItemStyle = .normal
    
    var icon: String? {
        
        didSet {
            
            if let icon = icon {
                
                self.imageView.image = UIImage(named: icon)
            }
        }
    }
    
    var title: String? {
        
        didSet {
            if let title = title {
                
                self.titleLabel.text = title
            }
        }
    }
    
    var titleColor: UIColor? {
        
        didSet {
            if let color = titleColor {
                
                self.titleLabel.textColor = color
            }
        }
    }
    
    var index: Int = 0 {
        
        didSet {
            
            index += defaultTag
        }
    }
    
    var badgeValue: String? {
        
        didSet {
            
            self.badgeLabel.text = badgeValue
        }
    }
    
    private lazy var imageView: UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        self.addSubview(img)
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.textColor = UIColor.gray
        self.addSubview(label)
        return label
    }()
    
    private lazy var badgeLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 8)
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        self.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(itemClicked))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let space: CGFloat = 6.0
        
        switch self.style {
        case .normal:
            
            let iconHeight = (self.frame.height - space*3)*2/3
            self.imageView.frame = CGRect(x: space, y: space, width: self.frame.width - 2*space, height: iconHeight)
            
            self.titleLabel.frame = CGRect(x: space, y: self.imageView.frame.maxY + space, width: self.frame.width - 2*space, height: iconHeight/2)
        case .image:
            
            self.imageView.frame = CGRect(x: space, y: space, width: self.frame.width - 2*space, height: self.frame.height - 2*space)
        case .text:
            
            self.titleLabel.frame = CGRect(x: space, y: space, width: self.frame.width - 2*space, height: self.frame.height - 2*space)
        }
        
        // TODO: - 增加角标的代码
//        self.badgeLabel.frame = CGRect(x: self.frame.width - 10, y: 0, width: 10, height: 10)
//        self.badgeLabel.layer.cornerRadius = 5
//        self.badgeLabel.layer.masksToBounds = true
    }
    
    @objc private func itemClicked() {
        
        self.delegate?.tabBarItem(self, didSelectIndex: self.index - defaultTag)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

protocol LZTabBarItemDelegate {
    
    func tabBarItem(_ item: LZTabBarItem, didSelectIndex index: Int)
}
