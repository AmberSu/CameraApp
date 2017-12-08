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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            images.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    // methods for showing main screen
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "backsg", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backsg" {
            let otherVc: ViewController = segue.destination as! ViewController
            otherVc.images = images
        }
    }
    
    // delegate method
    
    func photosMethod(photos: [UIImage]) {
        images = photos
    }
}
