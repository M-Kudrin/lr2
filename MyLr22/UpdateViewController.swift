
import UIKit
import CoreData

class UpdateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var nameMeet: UITextField!
    @IBOutlet weak var descriptionMeet: UITextView!
    @IBOutlet weak var isFreeMeetType: UISwitch!
    @IBOutlet weak var dateMeet: UIDatePicker!
    var met: Meet!
    @IBOutlet weak var buttonLabel: UIButton!
    var categoryArray = [Category]()
    
    var category: Category!
    
    @IBOutlet weak var tableViewCategories: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameMeet.text = met.name!
        if met.desc != nil {
            descriptionMeet.text = met.desc!
        }
        if met.isVisited != nil {
            isFreeMeetType.on = Bool(met.isVisited!)
        }
        descriptionMeet.layer.borderWidth = 2
        descriptionMeet.layer.borderColor = UIColor.lightGrayColor().CGColor
        dateMeet.layer.borderWidth = 2
        dateMeet.layer.borderColor = UIColor.lightGrayColor().CGColor
        dateMeet.setDate(met.date!, animated: true)
        
        tableViewCategories.layer.borderWidth = 2
        tableViewCategories.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        if met.category?.name != nil {
        buttonLabel.setTitle(met.category?.name, forState: .Normal)
        }
        else {
             buttonLabel.setTitle(NSLocalizedString("Nothing", comment: "Nothing Field"), forState: .Normal)
        }
        tableViewCategories.hidden = true
    }

    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        getCategoriesList(context)
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
    
    @IBAction func updateMeet(sender: AnyObject) {
        
         let isOn = isFreeMeetType.on
         met.setValue(nameMeet.text!, forKey: "name")
         met.setValue(descriptionMeet.text!, forKey: "desc")
         met.setValue(dateMeet.date, forKey: "date")
         met.setValue(isOn, forKey: "isVisited")
         if category != nil {
          met.addCategory(category)
         }
        
        do{
            try met.managedObjectContext?.save()
        }
        catch {
            let updateError = error as NSError
            print(updateError)
        }
         dismissViewControllerAnimated(true, completion: nil)
    }
   }
