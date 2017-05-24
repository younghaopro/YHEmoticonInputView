//
//  YHEmoticonInputView.swift
//  YHEmoticonInputView
//
//  Created by yanghao on 22/05/2017.
//  Copyright © 2017 yanghao. All rights reserved.
//

import UIKit



class YHEmoticonInputView: UIView {

    
    fileprivate lazy var collectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmotionCollectionViewLayout())
    fileprivate lazy var toolBar: UIToolbar = UIToolbar()
    fileprivate lazy var manager = YHEmoticonManager()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(toolBar)
        collectionView.backgroundColor = UIColor.purple
        toolBar.backgroundColor = UIColor.darkGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["tBar": toolBar, "cView": collectionView] as [String : Any]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[cView]-0-[tBar]-0-|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views)
        addConstraints(cons)
        prepareCollectionView()
        prepareToolBar()
        
    }
    fileprivate func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(YHEmoticonCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    fileprivate func prepareToolBar() {
        let titles = ["最近","默认","emoji","浪小花"]
        var items = [UIBarButtonItem]()
        var index = 0
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(itemDidTapped))
            item.tag = index
            index += 1
            items.append(item)
            
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        toolBar.items = items
        toolBar.tintColor = UIColor.orange
        
    }
    
    func itemDidTapped(item:UIBarButtonItem) {
        print("\(item.tag)")
        let indexPath = IndexPath(item: 0, section: item.tag)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YHEmoticonInputView:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pakage = manager.packages[section]
        return pakage.emotions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! YHEmoticonCell
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red:UIColor.blue
        let package = manager.packages[indexPath.section]
        let emoticon = package.emotions[indexPath.item]
        cell.emoticon = emoticon
        return cell
    }
}
extension YHEmoticonInputView:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let package =  manager.packages[indexPath.section]
        let emoticon = package.emotions[indexPath.item]
        insertRecentlyEmoticon(emoticon: emoticon)
    }
    
    fileprivate func insertRecentlyEmoticon(emoticon:YHEmoticon)
    {
        if emoticon.isRemove || emoticon.isEmpty {
            return
        }
        if manager.packages.first!.emotions.contains(emoticon) {
            let index = manager.packages.first?.emotions.index(of: emoticon)
            manager.packages.first?.emotions.remove(at: index!)
        } else {
            manager.packages.first?.emotions.remove(at: 19)
        }
        manager.packages.first?.emotions.insert(emoticon, at: 0)
        
    }
}
class EmotionCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemWH = collectionView!.bounds.size.width / 7
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        let margin = (collectionView!.bounds.size.height - 3 * itemWH) / 2
        collectionView?.contentInset = UIEdgeInsetsMake(margin, 0, margin, 0)
    }
}
