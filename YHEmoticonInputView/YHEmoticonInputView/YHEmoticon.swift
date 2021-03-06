//
//  YHEmoticon.swift
//  YHEmoticonInputView
//
//  Created by yanghao on 22/05/2017.
//  Copyright © 2017 yanghao. All rights reserved.
//

import UIKit

class YHEmoticon: NSObject {
    var code:String? {
        didSet {
            guard let code = code else {
                return
            }
            var value: UInt32 = 0
            let scanner  = Scanner(string: code)
            scanner.scanHexInt32(&value)
            let c  = Character(UnicodeScalar(value)!)
            emojiCode = String(c)
                    }
    }
    var png:String? {
        didSet {
            guard let png = png else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    }
    var chs:String?
    var pngPath:String?
    var emojiCode:String?
    var isRemove:Bool = false
    var isEmpty:Bool = false
    init(dict:[String:String]) {
        super.init()
        setValuesForKeys(dict)
    }
    init(isRemove:Bool) {
        self.isRemove = isRemove
    }
    init(isEmpty:Bool){
        self.isEmpty = isEmpty
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
 
    }
    override var description: String {
       return  dictionaryWithValues(forKeys: ["emojiCode", "png", "chs"]).description
    }
    
}

