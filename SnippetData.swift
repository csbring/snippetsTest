//
//  SnippetData.swift
//  Snippets
//
//  Created by chas on 2/9/17.
//  Copyright © 2017 chas. All rights reserved.
//

import Foundation
import UIKit

enum SnippetType : String {
    case text = "Text"
    case photo = "Photo"
}

class SnippetData{

    let type: SnippetType
    let date: Date
    
    init(snippetType: SnippetType, creationDate: Date){
        type = snippetType
        date = creationDate
        print ("new snippet for type \(type.rawValue) created")
    }

}

class TextData : SnippetData{

    let textData : String
    
    init(text: String, creationDate: Date){
        textData = text
        super.init(snippetType: .text, creationDate: creationDate)
        print("TEXT DATA CREATED FAM \(textData)")
    }
}

class PhotoData : SnippetData{
    let photoData : UIImage
    
    init (photo: UIImage, creationDate: Date){
    photoData = photo
    super.init(snippetType: .photo, creationDate: creationDate)
    print("created photo snippet data: \(photoData)")

    }
    
}
