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
    
    var images1 = [UIImage]()
    
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
        return images1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse") as! TableViewCell
        cell.picture.image = images1[indexPath.row]
        return cell
    }
    
    // methods for showing main screen
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "backsg", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backsg" {
            let otherVc: ViewController = segue.destination as! ViewController
            otherVc.delegate = self
        }
    }
    
    func photosMethod(photos: [UIImage]) {
        images1 = photos
    }
}
