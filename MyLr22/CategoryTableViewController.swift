//
//  CategoryTableViewController.swift
//  MyLr22
//
//  Created by Admin on 12.04.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

   
    
    @IBOutlet weak var categoryName: UITextField!
    var categoryArray = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellCategory", forIndexPath: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel!.text = category.valueForKey("name") as? String
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    @IBAction func addNewData(sender: AnyObject) {
        //let alertController = UIAlertController(title: "New Category", message: "Input new category", preferredStyle: .Alert)
        let alertController = UIAlertController(title: NSLocalizedString("Category", comment: "Category Field"), message: NSLocalizedString("New Category", comment: "New Category Field"), preferredStyle: .Alert)
        let inputAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
            
            let text = alertController.textFields?.first?.text
            let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            let entityValue = NSEntityDescription.entityForName("Category", inManagedObjectContext: context)
            let category = Category(entity: entityValue!, insertIntoManagedObjectContext:context)
            
            category.setValue(text!, forKey: "name")
            
            do {
                try context.save()
                
            } catch let error as NSError {
                
                print(error)
            }
            self.loadData()
        }
        
        //let actionCancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
         let actionCancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel Field"), style: .Cancel, handler: nil)
        alertController.addTextFieldWithConfigurationHandler(nil)
        alertController.addAction(inputAction)
        alertController.addAction(actionCancel)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func loadData()
    {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let entityValue = NSEntityDescription.entityForName("Category", inManagedObjectContext: context)
        
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = entityValue
        
        do{
            let result = try context.executeFetchRequest(fetchRequest)
            
            categoryArray = result as! [Category]
            
            self.tableView.reloadData()
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        if editingStyle == .Delete {
            
           // tableView.setEditing(true, animated: true)
            
            let category = categoryArray[indexPath.row]
            
            context.deleteObject(category)
            
            do{
                try context.save()
            }
            catch {
                let fetchError = error as NSError
                
                print(fetchError)
            }
            
            self.loadData()
        }
        
        if editingStyle == .Insert {
        }
    }

  
   }
