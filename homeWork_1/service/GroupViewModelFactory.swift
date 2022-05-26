//
//  GroupViewModelFactory.swift
//  homeWork_1
//
//  Created by Максим Лосев on 26.05.2022.
//  Copyright © 2022 Марат Нургалиев. All rights reserved.
//

import UIKit
import SDWebImage

final class GroupViewModelFactory {
    
    func constractViewModel(from groups :[Group]) -> [GroupViewModel] {
        return groups.compactMap(self.viewModel)
    }
    
    private func viewModel(from group: Group) -> GroupViewModel {
        let nameText = group.name
        let typeText = group.getType()
        let memberText = group.is_member > 0 ? "Вы вступили" : ""
        let iconImage = UIImageView()
        if group.photo.count > 0 {
            iconImage.sd_setImage(with: URL(string: group.photoBig), placeholderImage: UIImage(named: "noPhoto"))
        }
        return GroupViewModel(nameText: nameText,
                              typeText: typeText,
                              memberText: memberText,
                              iconImage: iconImage)
    }
    
    func constractViewModel(from groups :[VkGroup]) -> [GroupViewModel] {
        return groups.compactMap(self.viewModel)
    }
    
    private func viewModel(from group: VkGroup) -> GroupViewModel {
        let nameText = group.name
        let typeText = group.getType()
        let memberText = group.is_member > 0 ? "Вы вступили" : ""
        let iconImage = UIImageView()
        if group.photo.count > 0 {
            iconImage.sd_setImage(with: URL(string: group.photoBig), placeholderImage: UIImage(named: "noPhoto"))
        }
        return GroupViewModel(nameText: nameText,
                              typeText: typeText,
                              memberText: memberText,
                              iconImage: iconImage)
    }
    
}
