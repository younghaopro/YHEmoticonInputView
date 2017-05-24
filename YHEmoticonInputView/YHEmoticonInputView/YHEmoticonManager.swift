//
//  YHEmoticonManager.swift
//  YHEmoticonInputView
//
//  Created by yanghao on 22/05/2017.
//  Copyright © 2017 yanghao. All rights reserved.
//

import UIKit

class YHEmoticonManager {
    var packages:[YHEmoticonPakage] = [YHEmoticonPakage]()
    init() {
        packages.append(YHEmoticonPakage(id:""))
        packages.append(YHEmoticonPakage(id:"com.sina.default"))
        packages.append(YHEmoticonPakage(id:"com.apple.emoji"))
        packages.append(YHEmoticonPakage(id:"com.sina.lxh"))
    }
}
