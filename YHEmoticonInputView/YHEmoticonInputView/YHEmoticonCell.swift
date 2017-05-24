//
//  YHEmoticonCell.swift
//  YHEmoticonInputView
//
//  Created by yanghao on 24/05/2017.
//  Copyright © 2017 yanghao. All rights reserved.
//

import UIKit

class YHEmoticonCell: UICollectionViewCell {
    var emoticon:YHEmoticon? {
        didSet {
            guard let emoticon = emoticon else {
                return
            }
            
            emoticonButton.setImage(UIImage.init(contentsOfFile: emoticon.pngPath ?? ""), for: .normal)
            emoticonButton.setTitle(emoticon.emojiCode, for: .normal)
            if emoticon.isRemove {
                emoticonButton.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
            }
            if emoticon.isEmpty {
                emoticonButton.setImage(UIImage(named: ""), for: .normal)
            }
        }
    }
    fileprivate lazy var emoticonButton :UIButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YHEmoticonCell  {
    func initSubviews() {
        contentView.addSubview(emoticonButton)
        emoticonButton.frame = contentView.bounds
        emoticonButton.isUserInteractionEnabled = false
        emoticonButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
}
