//
//  GenericView.swift
//  Softcom
//
//  Created by Olar's Mac on 5/18/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

struct TypeView {
    static func typeRet(type: String, placeholder: String?) -> UIView {
        switch type {
        case "text":
            let tf = DefaultTextField()
            tf.placeholder = placeholder
            return tf
        case "embeddedphoto":
            return UIImageView()
        case "formattednumeric":
            let tf = DefaultTextField()
            tf.placeholder = placeholder
            tf.keyboardType = .numberPad
            return tf
        case "datetime":
            return UIDatePicker()
        case "yesno":
            let tf = DefaultTextField()
            tf.placeholder = placeholder
            return tf
        default:
            return UIView();
        }
    }
    
    static func typeCell(element: ElementsModel) -> CustomElementType {
        switch element.type {
        case "text":
            return .text
        case "embeddedphoto":
            return .embeddedphoto
        case "formattednumeric":
            return .formattednumeric
        case "datetime":
            return .datetime
        case "yesno":
            return .yesno
        default:
            return .text
        }
    }
}

