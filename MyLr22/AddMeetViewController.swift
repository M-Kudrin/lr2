
import UIKit
import CoreData

class AddMeetViewController: UIViewController {

    @IBOutlet weak var nameMeet: UITextField!
    @IBOutlet weak var descriptionMeet: UITextView!
    @IBOutlet weak var dateMeet: UIDatePicker!
    @IBOutlet weak var isVisited: UISwitch!
    @IBOutlet weak var buttonLabel: UIButton!
    var category: Category!
    @IBOutlet weak var tableViewCategories: UITableView!
    var categoryArray = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         descriptionMeet.layer.borderWidth = 2
         nameMeet.layer.borderColor = UIColor.lightGrayColor().CGColor
         nameMeet.layer.borderWidth = 2
         descriptionMeet.layer.borderColor = UIColor.lightGrayColor().CGColor
         tableViewCategories.hidden = true
         tableViewCategories.layer.borderColor = UIColor.lightGrayColor().CGColor
         tableViewCategories.layer.borderWidth = 2
    }

    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        getCategoriesList(context)
    }

    @IBAction func saveNewMeet(sender: AnyObject) {
       
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let entityValue = NSEntityDescription.entityForName("Meet", inManagedObjectContext: context)
        
        let meet = Meet(entity: entityValue!, insertIntoManagedObjectContext:context)
        
            meet.setValue(descriptionMeet.text!, forKey: "desc")
            
            meet.setValue(nameMeet.text!, forKey: "name")
            meet.setValue(dateMeet.date, forKey: "date")
            meet.setValue(isVisited.on, forKey: "isVisited")
        
        if categoryArray.count != 0 {
            if category != nil {
                meet.addCategory(category)
            }
        }
            do {
               try context.save()
                
            } catch let error as NSError {
                
                print(error)
            }
        
      dismissViewControllerAnimated(true, completion: nil)
        }
    
    func getCategoriesList(context:NSManagedObjectContext)
    {
        let entityValue = NSEntityDescription.entityForName("Category", inManagedObjectContext: context)
        
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = entityValue
        
        do{
            let result = try context.executeFetchRequest(fetchRequest)
            
            categoryArray = result as! [Category]
        }
        catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    @IBAction func categoryInput(sender: AnyObject) {
        self.tableViewCategories.hidden = !self.tableViewCategories.hidden
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellTable", forIndexPath: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name!
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        buttonLabel.setTitle(cell?.textLabel?.text, forState: .Normal)
        tableViewCategories.hidden = true
        category = categoryArray[indexPath.row]
    }
    }
