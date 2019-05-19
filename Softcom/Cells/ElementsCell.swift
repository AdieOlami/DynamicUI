//
//  ElementsCell.swift
//  Softcom
//
//  Created by Olar's Mac on 5/19/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit
import Kingfisher

class ElementsCell: UITableViewCell, CustomElementCell {

    var model: ElementsModel!
    private let productNameLabel: DefaultLabel = {
        let lbl = DefaultLabel()
        return lbl
    }()
    
    private let tf: DefaultTextField = {
        let tf = DefaultTextField()
        return tf
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withModel elementModel: ElementsModel) {
        guard let model = elementModel as? ElementsModel else {
            log("Unable to cast model as ProfileElement: \(elementModel)", .error)
            return
        }
        
        self.model = model
        configureUI(element: model)
    }
    
    func configureUI(element: ElementsModel) {
        
        let types = TypeView.typeCell(element: element)
        switch types {
            
        case .text:
            let tf = DefaultTextField()
            tf.placeholder = element.label
            addSubview(tf)
            tf.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 6, width: frame.size.width, height: frame.size.height, enableInsets: false)
        case .embeddedphoto:
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            let url = URL(string: element.file ?? "")
            imageView.kf.setImage(with: url)
            
            addSubview(imageView)
            imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 6, width: frame.size.width, height: frame.size.height + 70, enableInsets: false)
        case .formattednumeric:
            let tf = DefaultTextField()
            tf.placeholder = element.label
            tf.keyboardType = .numberPad
            addSubview(tf)
            tf.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 6, width: frame.size.width, height: frame.size.height, enableInsets: false)
        case .datetime:
            let dp = UIDatePicker()
            addSubview(dp)
            dp.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 6, width: frame.size.width, height: frame.size.height + 50, enableInsets: false)
        case .yesno:
            let dropdown = DropDown()
            dropdown.placeholder = element.label
            dropdown.optionArray = ["yes", "no"]
            addSubview(dropdown)
            dropdown.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 6, paddingBottom: 0, paddingRight: 6, width: frame.size.width, height: frame.size.height, enableInsets: false)
            
        }

    }

}








//I have a project I am working on which I am trying to create form depending on a JSON response, I have made progress so far but the issue I have now is how to actually set the CustomCell to display items from the available model.
//
//the JSON file changes but the possible elements are with components, textfield, imageview, datepicker. I have successfully passed the JSON into my model and now I am left with how to actually create the cells
//
//below is what my code looks like
//
//struct ElementsModel: Codable {
//    let type: String?
//    let label: String?
//    let file: String?
//    let keyboard: String?
//    let formattedNumeric: String?
//    let isMandatory: Bool?
//    let unique_id: String?
//}
