//
//  TextSnippetEntryViewController.swift
//  Snippets
//
//  Created by chas on 2/9/17.
//  Copyright © 2017 chas. All rights reserved.
//

import Foundation
import UIKit

class TextSnippetEntryViewController : UIViewController{

    var saveText: (_ text: String) -> Void = { (text:String) in }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.inputAccessoryView = createKeyBoardToolbar()
        
        textView.becomeFirstResponder()
    }
    
    @objc
    func doneButtonPressed(){
        textView.resignFirstResponder()
    }
    
    
    func createKeyBoardToolbar() -> UIView {
        let keyboardToolbar = UIToolbar(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: 44))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed)  )
        
        keyboardToolbar.setItems([flexSpace, doneButton], animated: false)
        
        return keyboardToolbar
    }

}
    extension TextSnippetEntryViewController : UITextViewDelegate {
        func textViewDidEndEditing(textView : UITextView){
            saveText(textView.text)
            self.dismiss(animated: true, completion: nil)
        }
    
}
    
