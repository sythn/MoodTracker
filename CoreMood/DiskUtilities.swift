////
////  DiskUtilities.swift
////  MoodTracker
////
////  Created by Seyithan Teymur on 03/01/16.
////  Copyright © 2016 Brokoli. All rights reserved.
////
//
//import Foundation
//
//private var listUtilitiesQueue: NSOperationQueue = {
//    let queue = NSOperationQueue()
//    queue.maxConcurrentOperationCount = 1
//    
//    return queue
//}()
//
//public class DiskUtilities {
//    
//    private class var sharedApplicationGroupContainer: NSURL {
//        let containerURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(AppConfiguration.ApplicationGroups.primary)
//        
//        if containerURL == nil {
//            fatalError("The shared application group container is unavailable. Check your entitlements and provisioning profiles for this target. Details on proper setup can be found in the PDFs referenced from the README.")
//        }
//        
//        return containerURL!
//    }
//    
//    public class var localDocumentsDirectory: NSURL  {
//        let documentsURL = sharedApplicationGroupContainer.URLByAppendingPathComponent("Documents", isDirectory: true)
//        
//        do {
//            // This will throw if the directory cannot be successfully created, or does not already exist.
//            try NSFileManager.defaultManager().createDirectoryAtURL(documentsURL, withIntermediateDirectories: true, attributes: nil)
//            
//            return documentsURL
//        }
//        catch let error as NSError {
//            fatalError("The shared application group documents directory doesn't exist and could not be created. Error: \(error.localizedDescription)")
//        }
//    }
//    
//    public class func daysAtURL(url: NSURL) -> [Day] {
//        
//    }
//}
