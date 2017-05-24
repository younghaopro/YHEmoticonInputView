//
//  ViewController.swift
//  YHEmoticonInputView
//
//  Created by yanghao on 22/05/2017.
//  Copyright © 2017 yanghao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.inputView = YHEmoticonInputView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 219))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

