//
//  MainGroupViewController.swift
//  homeWork_1
//
//  Created by Admin on 12/5/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class MainGroupViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerGroups: UIView!
    
    private var currentSegment = 0
    
    private lazy var myGroupsViewController: GroupsViewController = {
        let vc = storyboard!.instantiateViewController(withIdentifier: "MyGroups")
        self.add(childViewController: vc)
        return vc as! GroupsViewController
    }()
    
    private lazy var searchGroupsViewController: SearchGroupViewController = {
        let vc = storyboard!.instantiateViewController(withIdentifier: "SearchGroups")
        self.add(childViewController: vc)
        return vc as! SearchGroupViewController
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    private func configureView() {
        setSegmentedControlSettings()
        add(childViewController: myGroupsViewController)
    }
    
    
    private func setSegmentedControlSettings() {
        segmentedControl.backgroundColor = UIColor.VkColor.main
        segmentedControl.tintColor = .clear
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont.VkFont.fontNormal,
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
        ], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont.VkFont.fontSelect,
            NSAttributedStringKey.foregroundColor: UIColor.VkColor.main
        ], for: .selected)
        
    }
    
    
    
    @IBAction func segmentControlDidChanged(_ sender: Any) {
        if currentSegment != segmentedControl.selectedSegmentIndex {
            currentSegment = segmentedControl.selectedSegmentIndex
            
            switch segmentedControl.selectedSegmentIndex
            {
            case 0:
                add(childViewController: myGroupsViewController)
            case 1:
                add(childViewController: searchGroupsViewController)
            default:
                break;
            }
        }
    }
    
    
    
    
    
    
}

//MARK: - Work with ContainerView

extension MainGroupViewController {
    
    func add(childViewController: UIViewController) {
        for view in containerGroups.subviews {
            view.removeFromSuperview()
        }
        
        childViewController.view.frame = CGRect(x: 0,
                                                y: 0,
                                                width: containerGroups.frame.width,
                                                height: containerGroups.frame.height)
        
        containerGroups.addSubview(childViewController.view)
        
    }
    
}
