//
//  DefaultTextField.swift
//  Softcom
//
//  Created by Olar's Mac on 5/18/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class DefaultTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shared()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shared() {
        textColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Avenir", size: 16)
        textAlignment = .left
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
}
