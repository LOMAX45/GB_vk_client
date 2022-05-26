//
//  Group.swift
//  homeWork_1
//
//  Created by Максим Лосев on 25.05.2022.
//  Copyright © 2022 Марат Нургалиев. All rights reserved.
//

import Foundation

struct Group {
    var gid: Int
    var is_admin: Int
    var is_closed: Int
    var is_member: Int
    var name: String
    var type: String
    var photo: String
    var photoBig: String
    var screenName: String
    var photoMedium: String
    
    func getType() -> String {
        switch type {
        case "event":
            return "Мероприятие"
        case "group":
            return "Группа"
        case "page":
            return "Публичная страница"
        default:
            return ""
        }
    }
}
