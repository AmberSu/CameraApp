//
//  SecondViewController.swift
//  CameraApp2
//
//  Created by MacOS on 05/12/2017.
//  Copyright © 2017 amberApps. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PhotosDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // TableView methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse") as! TableViewCell
        cell.picture.image = images[indexPath.row]
        return cell
    }
    
    // methods for showing main screen
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "backsg", sender: self)
    }
    
    // delegate method
    
    func photosMethod(photos: [UIImage]) {
        images = photos
        print("second view \(images)")
    }
}
