//
//  ViewController.swift
//  Snippets
//
//  Created by chas on 2/9/17.
//  Copyright © 2017 chas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data: [SnippetData] = [SnippetData]()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func createNewSnippet(_ sender: AnyObject) {
        print("New button pressed")
        
        let alert = UIAlertController(title: "Select a snippet type.",
                            message: nil, preferredStyle: .alert)
        
        let textAction = UIAlertAction(title: "Text", style: .default){
            (alert: UIAlertAction!) -> Void in
            self.createNewTextSnippet()
        }
        let photoAction = UIAlertAction(title: "Photo", style: .default) {
            (alert:UIAlertAction!) -> Void in
            self.createNewPhotoSnippet()
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    
    
        alert.addAction(textAction)
        alert.addAction(photoAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
        
    }
    
    func createNewTextSnippet(){
        guard let textEntryVC = storyboard?.instantiateViewController(withIdentifier: "textSnippetEntry") as? TextSnippetEntryViewController
        else{
            print("TextSnippetEntryViewController could not be instantiated from storyboard")
            return
        }
        textEntryVC.modalTransitionStyle = .coverVertical
        let now = Date()
        textEntryVC.saveText = {(text: String ) in
            let newTextSnippet = TextData(text: text, creationDate: now )
            self.data.append(newTextSnippet)
            }
        
        present(textEntryVC, animated:true, completion: nil)
        
    }
    
    func createNewPhotoSnippet() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera)
        else{
            print("Camera aint available")
            return
        }
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

}
extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage
        else{
            print("image could not be found")
            return
        }
        let now = Date()
        let newPhotoSnippet = PhotoData(photo: image, creationDate: now)
        self.data.append(newPhotoSnippet)
        
        dismiss(animated: true, completion: nil)
    }
    
}
extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        let sortedData = data.reversed() as [SnippetData]
        let snippetData = sortedData[indexPath.row]
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyy hh:mm a"
        let dateString = formatter.string(from: snippetData.date)
        
        switch snippetData.type{
        case .text:
            cell = tableView.dequeueReusableCell(withIdentifier: "textSnippetCell", for: indexPath)
                (cell as! TextSnippetCell).label.text = (snippetData as! TextData) .textData
                (cell as! TextSnippetCell).dateLabel.text = dateString
        case .photo:
            cell = tableView.dequeueReusableCell(withIdentifier: "photoSnippetCell", for: indexPath)
            (cell as! PhotoSnippetCell).photo.image = (snippetData as! PhotoData) .photoData
        }
        return cell
    }
    
}

