//
//  DefaultButton.swift
//  Softcom
//
//  Created by Olar's Mac on 5/19/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shared()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shared() {
        setTitleColor(.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
//        heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
}
