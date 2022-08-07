//
//  ViewController.swift
//  DaycareCalc
//
//  Created by Daniel Gonzalez on 8/6/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var kids = KidsDataController.controller.retrieveChildren()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kids!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KidsCollectionViewCell.identifier, for: indexPath) as! KidsCollectionViewCell
        let kid = kids![indexPath.item] as! Kids
        cell.configure(with: UIImage(named: "photo")!, name: kid.name!)
        return cell
    }
    
}

