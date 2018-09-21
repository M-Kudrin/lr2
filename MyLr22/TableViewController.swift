
import UIKit
import CoreData

class TableTableViewController: UITableViewController {
    
    var testArray = [Meet]()
    
    var metUpdate: Meet!

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
        return testArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let met = testArray[indexPath.row]
        
        cell.textLabel!.text = met.valueForKey("name") as? String

        return cell
    }
    
    func loadData()
    {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let entityValue = NSEntityDescription.entityForName("Meet", inManagedObjectContext: context)
        
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = entityValue
        
        do{
            let result = try context.executeFetchRequest(fetchRequest)
            
            testArray = result as! [Meet]
            
            self.tableView.reloadData()
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSegue" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                 print(indexPath.row)
                let newController = segue.destinationViewController as! ViewController
            
                newController.met = testArray[indexPath.row]
            }
        }
        
        else if segue.identifier == "updateSegue" {

                let updateController = segue.destinationViewController as! UpdateViewController
    
                updateController.met = metUpdate!
   
        }
    }

    @IBAction func unwindToMeets(segue: UIStoryboardPopoverSegue){
    
    }
    
    func goToUpdateViewController()
    {
        performSegueWithIdentifier("updateSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
       // let insertAction = UITableViewRowAction(style: .Default, title: "Update") { (action: UITableViewRowAction, path2: NSIndexPath) -> Void in
        let insertAction = UITableViewRowAction(style: .Default, title: NSLocalizedString("Update", comment: "Update Field")) { (action: UITableViewRowAction, path2: NSIndexPath) -> Void in
   
           self.metUpdate = self.testArray[path2.row]
            print(self.metUpdate.name!)
           self.goToUpdateViewController()
        }
        
        insertAction.backgroundColor = UIColor.blueColor()
        
       // let deleteAction = UITableViewRowAction(style: .Destructive, title: "Delete") { (action: UITableViewRowAction, path: NSIndexPath) -> Void in
        let deleteAction = UITableViewRowAction(style: .Destructive, title: NSLocalizedString("Delete", comment: "Delete Field")) { (action: UITableViewRowAction, path: NSIndexPath) -> Void in
            
            let met = self.testArray[path.row]
            
            context.deleteObject(met)
            
            do{
                try context.save()
            }
            catch {
                let fetchError = error as NSError
                
                print(fetchError)
            }
            
            self.loadData()
        }
        
        deleteAction.backgroundColor = UIColor.redColor()

        
        return [insertAction, deleteAction]
    }
    
    }
