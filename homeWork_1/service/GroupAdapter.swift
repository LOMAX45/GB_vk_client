//
//  GroupAdapter.swift
//  homeWork_1
//
//  Created by Максим Лосев on 25.05.2022.
//  Copyright © 2022 Марат Нургалиев. All rights reserved.
//

import Foundation
import RealmSwift

final class GroupAdapter {
    
    private var realmNotificationTokens: NotificationToken?
    
    func getGroups(then completion: @escaping ([Group]) -> Void) {
         guard let groups = RealmWorker.instance.getItems(VkGroup.self)?.sorted(byKeyPath: "name") else { return }
        
        let token = groups.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            var groups: [Group] = []
            switch changes {
            case .update(let vkGroups, _, _, _):
                for vkGroup in vkGroups {
                    groups.append(self.group(from: vkGroup))
                }
            completion(groups)
            case .error(let error):
                fatalError("\(error)")
            case .initial (let vkGroups):
                for vkGroup in vkGroups {
                    groups.append(self.group(from: vkGroup))
                }
            completion(groups)
            }
        }
        realmNotificationTokens = token
        AlamofireService.instance.getGroups()
    }
    
    func getMySearchGroup(with search: String, then completion: @escaping ([Group]) -> Void) {
        guard let filteredGroups = RealmWorker.instance.getItems(VkGroup.self)?.filter("name contains[c] '\(search)'").sorted(byKeyPath: "name") else { return }
        var groups: [Group] = []
                for vkGroup in filteredGroups {
                    groups.append(self.group(from: vkGroup))
                }
        completion(groups)
    }
    
    func vkGroup(from group: Group) -> VkGroup {
        let vkGroup = VkGroup()
        vkGroup.gid = group.gid
        vkGroup.is_admin = group.is_admin
        vkGroup.is_closed = group.is_closed
        vkGroup.is_member = group.is_member
        vkGroup.name = group.name
        vkGroup.type = group.type
        vkGroup.photo = group.photo
        vkGroup.photoBig = group.photoBig
        vkGroup.screenName = group.screenName
        vkGroup.photoMedium = group.photoMedium
        return vkGroup
    }
    
    func group(from VkGroup: VkGroup) -> Group {
        return Group(gid: VkGroup.gid,
                     is_admin: VkGroup.is_admin,
                     is_closed: VkGroup.is_closed,
                     is_member: VkGroup.is_member,
                     name: VkGroup.name,
                     type: VkGroup.type,
                     photo: VkGroup.photo,
                     photoBig: VkGroup.photo,
                     screenName: VkGroup.screenName,
                     photoMedium: VkGroup.photoMedium)
    }
    
}
