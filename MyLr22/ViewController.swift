

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameMeet: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var dateMeet: UIDatePicker!
    
    @IBOutlet weak var categoryName: UITextField!
    
    @IBOutlet weak var isVisited: UISwitch!
    var met: Meet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionField.layer.borderWidth = 2
        nameMeet.layer.borderWidth = 2
        nameMeet.layer.borderColor = UIColor.lightGrayColor().CGColor
        descriptionField.layer.borderColor = UIColor.lightGrayColor().CGColor
        categoryName.layer.borderWidth = 2
        categoryName.layer.borderColor = UIColor.lightGrayColor().CGColor
        nameMeet.text = met.name!
        
        descriptionField.text = met.desc!
        
        dateMeet.setDate(met.date!, animated: true)
       
        if met.isVisited != nil{
        isVisited.on = Bool(met.isVisited!)
        }
        if met.category != nil{
            let category: Category = met.category!
            let name: String = category.name!
            categoryName.text = name
        }
        else{
            //categoryName.text = "Nothing"
            categoryName.text = NSLocalizedString("Nothing", comment: "Nothing Field")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

