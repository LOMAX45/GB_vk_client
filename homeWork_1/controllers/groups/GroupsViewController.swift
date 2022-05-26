//
//  MyGroupsViewController.swift
//  homeWork_1
//
//  Created by Admin on 01.10.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var groups: [Group] = []
    private var filteredGroups: [Group] = []
    private var notificationTokenGroups: NotificationToken?
    private var notificationTokenSearchGroups: NotificationToken?
    private let groupAdapterService = GroupAdapter()
    
    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewSettings()
        setSearchBarSettings()
        getMyGroups()
        
    }

    private func setTableViewSettings() {
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    private func setSearchBarSettings() {
        searchBar.delegate = self
    }
    
    
    private func removeObserver() {
        notificationTokenGroups = nil
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
}

extension GroupsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchActive {
            searchActive = false
            tableView.reloadData()
            self.view.endEditing(true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Подумать над переделкой
        searchActive = (searchBar.text?.count)! > 0 ? true:false
        tableView.reloadData()
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
        if searchText == "" {
            searchActive = false
            getMyGroups()
        } else {
            searchActive = true
            groupAdapterService.getSearchGroup(with: searchText) { [weak self] groups in
                self?.filteredGroups = groups
                self?.tableView.reloadData()
            }
        }
    }
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filteredGroups.count : groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupCell
        let group = searchActive ? filteredGroups[indexPath.row] : groups[indexPath.row]
        cell.load(group)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let row = editActionsForRowAt.row
        let group = searchActive ? filteredGroups[row] : groups[row]
        if group.name != "" {
            let isMember = group.is_member > 0
            let leaveJoin = UITableViewRowAction(style: .normal, title: isMember ? "Покинуть":"Вступить") { action, index in
                let gid = group.gid
                let name = group.name
                self.groupSelected(gid: gid, name: name, isMember: isMember)
            }
            leaveJoin.backgroundColor = isMember ? .red : UIColor.VkColor.main
            return [leaveJoin]
        }
        return [UITableViewRowAction()]
    }
    
    func groupSelected(gid: Int, name: String, isMember: Bool) {
        let alert = UIAlertController(title: name, message: isMember ? "Вы действительно хотите покинуть группу?":"Вы действительно хотите вступить в эту группу?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: isMember ? "Покинуть":"Вступить", style: .default, handler: { action in
            isMember ? self.leaveGroup(by: gid) : self.joinGroup(by: gid)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}

//MARK: - Network funcs
extension GroupsViewController {
    
    private func getMyGroups() {
        groupAdapterService.getGroups { [weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
        }
    }

    private func leaveGroup(by gid: Int) {
        AlamofireService.instance.leaveGroup(gid: gid, delegate: self)
    }
    
    private func joinGroup(by gid: Int) {
        AlamofireService.instance.joinGroup(gid: gid, delegate: self)
    }
}

extension GroupsViewController: VkApiGroupsDelegate {
    func returnJoin(_ gid: Int) {}
    func returnJoin(_ error: String) {}
    func returnLeave(_ error: String) {}
    
    func returnLeave(_ gid: Int) {
        if groups.count > 0 {
            for  group in groups {
                if group.gid == gid {
                    let vkGroup = groupAdapterService.vkGroup(from: group)
                    RealmWorker.instance.removeItem(vkGroup)
                    tableView.reloadData()
                    break
                }
            }
        }
    }

    private func deleteGroup(gid: Int, index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: .top)
    }
    
    func returnGroups(_ groups: [VkGroup]) { }
    
}
