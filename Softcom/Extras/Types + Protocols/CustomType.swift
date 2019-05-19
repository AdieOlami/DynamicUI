//
//  CustomType.swift
//  Softcom
//
//  Created by Olar's Mac on 5/19/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

enum CustomElementType: String {
    case text
    case embeddedphoto
    case formattednumeric
    case datetime
    case yesno
}

protocol CustomElementModel: class {
    var type: CustomElementType { get }
    var elements: ElementsModel { get }
}

protocol CustomElementCell: class {
    func configure(withModel: ElementsModel)
}
