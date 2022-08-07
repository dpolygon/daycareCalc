//
//  ViewController.swift
//  DaycareCalc
//
//  Created by Daniel Gonzalez on 8/6/22.
//

import UIKit
import CoreData

protocol updateDataRemotely {
    func updateCollectionWithNewKid(kid: NSManagedObject)
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, updateDataRemotely{
    
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
        cell.configure(with: UIImage(data: kid.picture!)!, name: kid.name!)
        return cell
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        KidsDataController.controller.deleteAllData()
        kids = [NSManagedObject]()
        collectionView.reloadData()
    }
    
    func updateCollectionWithNewKid(kid: NSManagedObject) {
        kids?.append(kid)
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newKidSegue" {
            let nextVC = segue.destination as! NewKidViewController
            nextVC.delegate = self
        }
    }
    
}
