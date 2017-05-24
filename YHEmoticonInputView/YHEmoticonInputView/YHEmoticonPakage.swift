//
//  YHEmoticonPakage.swift
//  YHEmoticonInputView
//
//  Created by yanghao on 22/05/2017.
//  Copyright © 2017 yanghao. All rights reserved.
//

import UIKit

class YHEmoticonPakage: NSObject {
    var emotions:[YHEmoticon] = [YHEmoticon]()
    init(id:String) {
        super.init()
        if id == "" {
            addEmptyEmoticon(isRecently: true)
            return
        }
        let plistInpath  = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        let array  = NSArray(contentsOfFile:plistInpath!) as! [[String:String]]
        var index = 0
        for var dict in array {
            if let png = dict["png"] {
                dict["png"] = id + "/" + png
            }
            emotions.append(YHEmoticon(dict:dict))
            index += 1
            if index == 20 {
                emotions.append(YHEmoticon(isRemove: true))
                index = 0
            }
        }
        addEmptyEmoticon(isRecently: false)
    }
    
    fileprivate func addEmptyEmoticon(isRecently:Bool) {
        let count = emotions.count % 21
        if count == 0 && !isRecently {
            return
        }
        for _ in count..<20 {
            emotions.append(YHEmoticon(isEmpty:true))
        }
        emotions.append(YHEmoticon(isRemove: true))
    }
}
