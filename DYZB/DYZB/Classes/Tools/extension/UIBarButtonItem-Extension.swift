//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by saber on 2020/10/28.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    convenience init(_ image: String, _ selectImage: String = "", _ size: CGSize = CGSize.zero){
        let btn = UIButton()
        
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else{
            btn.sizeToFit()
        }
        
        btn.setImage(UIImage(named: image), for: .normal)
        if selectImage != "" {
            btn.setImage(UIImage(named: selectImage), for: .highlighted)
        }
        
        self.init(customView: btn)
    }
    
}
