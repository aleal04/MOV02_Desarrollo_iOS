//
//  ViewController.swift
//  AgeCalculator
//
//  Created by Andrey Leal on 21/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dobTextField: UITextField!
    
    var datepicker: UIDatePicker?
    var toolBar:UIToolbar = UIToolbar()
    var dateOfBirth:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.doDatePicker()
    }
    
    func doDatePicker(){
        //DatepIKCER
        //Create a datepicker object with some frame
        
        self.datepicker = UIDatePicker(frame: CGRect(x: 0 , y:0 ,
                                                            width: self.view.frame.size.width,
                                                            height: 200))
        
        //set mode of date
        self.datepicker?.datePickerMode = UIDatePicker.Mode.date
        
        //IOS 14 Calendar
        //We need to set the default
        datepicker?.preferredDatePickerStyle = UIDatePickerStyle.wheels
        
        //Max date
        datepicker?.maximumDate = Date()
        //Set datepicker to textfiled input view
        dobTextField.inputView = datepicker
        
        //ToolBar
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255 , green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        //Adding button toolbar
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.doneClick))
        
        let spacebutton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel" , style: .plain,
                                           target: self ,
                                           action: #selector(self.cancelClick))
        
        toolBar.setItems([cancelButton , spacebutton , doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        dobTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateOfBirth = datepicker?.date
        dobTextField.text = dateFormatter.string(from: dateOfBirth!)
        self.view.endEditing(true)
    }
    
    @objc func cancelClick(){
        self.view.endEditing(true)
    }

    
    @IBAction func calculateAgeBtnAxn(_ sender: Any){
        if let dob = dateOfBirth{
            let today = Date()
            let calendar = Calendar.current
            let age = calendar.dateComponents([.year , .month , .day], from: dob , to: today)
            let ageInYear = age.year ?? 0
            let ageInMonths = age.month ?? 0
            let ageInDays = age.day ?? 0
            
            ageLabel.text = "\(ageInYear)yr \(ageInMonths)m \(ageInDays)d"
        }
    }

}

