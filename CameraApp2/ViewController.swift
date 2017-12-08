//
//  ViewController.swift
//  CameraApp2
//
//  Created by MacOS on 01/12/2017.
//  Copyright © 2017 amberApps. All rights reserved.
//

import UIKit

protocol PhotosDelegate {
    func photosMethod(photos: [UIImage])
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController!
    var images = [UIImage]()
    var delegate: PhotosDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // method for adding pictures from camera or library
    
    @IBAction func takePicture(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo source", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // methods for saving pictures to the library
    
    @IBAction func saveImage(_ sender: UIButton) {
        if let image = imageView.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
        } else {
            let alert = UIAlertController(title: "Image missing", message: "Please choose an image to save", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .`default`, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func saveImage(_ image: UIImage?, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer?) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Image saved!", message: "The image is now saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    // methods for sending images to the second view
    
    @IBAction func showImages(_ sender: UIButton) {
        if !images.isEmpty {
            delegate?.photosMethod(photos: images)
        } 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let otherVc: SecondViewController = segue.destination as! SecondViewController
            delegate = otherVc
        } 
    }
    
    // methods for showing an image on the main screen
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            images.append(image)
        }
        self.dismiss(animated: true, completion: nil)
    }
}




