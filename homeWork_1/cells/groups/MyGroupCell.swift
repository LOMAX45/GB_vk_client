//
//  MyGroupCell.swift
//  homeWork_1
//
//  Created by Admin on 01.10.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SDWebImage

class MyGroupCell: UITableViewCell {

    @IBOutlet weak var imageAva: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelMember: UILabel!
    
    var group: Group!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: GroupViewModel) {
        labelName.text = viewModel.nameText
        labelType.text = viewModel.typeText
        labelMember.text = viewModel.memberText
        imageAva = viewModel.iconImage
    }

}
