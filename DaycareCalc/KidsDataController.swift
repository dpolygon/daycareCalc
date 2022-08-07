//
//  KidsDataController.swift
//  DaycareCalc
//
//  Created by Daniel Gonzalez on 8/6/22.
//

import Foundation
import UIKit
import CoreData

// Handles all website data storage/retrieval in Core Data
class KidsDataController {
    
    // Controller allows you to interact with Core Data functions
    static let controller = KidsDataController()
    
    var entityName = "Kids"
    var appDelegate: AppDelegate
    var context: NSManagedObjectContext
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    // Stores website data to core Data
    func createKid(name: String, picture: UIImage) -> NSManagedObject? {
        let kid = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        kid.setValue(name, forKey: "name")
        let dataPic = picture.pngData()! as NSData
        kid.setValue(dataPic, forKey: "picture")
        appDelegate.saveContext()
        return kid
    }
    
//    // Updates the same current Website data that is being created to new user specifications in Core Data
//    func updateKid(website: NSManagedObject?, websiteName: String, username: String, password: String, tag: String) {
//        if let website = website {
//            website.setValue(websiteName, forKey: "websiteName")
//            website.setValue(username, forKey: "username")
//            website.setValue(password, forKey: "password")
//            website.setValue(tag, forKey: "tag")
//            appDelegate.saveContext()
//        }
//        appDelegate.saveContext()
//    }
    
    // Fetch all websites stored in Core Data, return websites in an array
    func retrieveChildren() -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var fetchedResults: [NSManagedObject]? = nil
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            runErrorMessage(error: error, message: "an error has occurred when attempting to retrieve websites")
        }
        return fetchedResults
    }
    
//    // search for Keyp using website name
//    func searchKeyps(contains: String) -> [NSManagedObject]? {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        let pred = NSPredicate(format: "websiteName CONTAINS[c] '\(contains)'")
//        request.predicate = pred
//        var fetchedResults: [NSManagedObject]? = nil
//        do {
//            try fetchedResults = context.fetch(request) as? [NSManagedObject]
//        } catch {
//            runErrorMessage(error: error, message: "an error has occurred when attempting to retrieve websites")
//        }
//        return fetchedResults
//    }
//
    
//    // Deletes a specified 'website' from Core Data
//    func deleteWebsite(website: NSManagedObject) {
//        context.delete(website)
//        appDelegate.saveContext()
//    }
    
    // Remove all websites from Core Data
    func deleteAllData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            runErrorMessage(error: error, message: "request to delete all entities pretaining to \(entityName) has failed")
        }
        appDelegate.saveContext()
    }
    
    // Any failure to retrieve data from Core Data or
    // failure to save the context will call on this func
    // error information will be printed to console
    func runErrorMessage(error: Error, message: String) {
        print(message)
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
}
