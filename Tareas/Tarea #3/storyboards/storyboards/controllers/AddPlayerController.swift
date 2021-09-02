//
//  AddPlayerController.swift
//  storyboards
//
//  Created by Andrey Leal on 2/9/21.
//
import UIKit

// MARK: - AddContactDelegate Protocol
protocol AddPlayerDelegate {
    func addPlayer(name:String , stars:String)
}

// MARK: - AddPlayerController
class AddPlayerController: UITableViewController, UITextFieldDelegate{
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldStars: UITextField!
    
    var delegate: AddPlayerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldStars.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"12345").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 1 && string == filtered
    }
    
    
    @IBAction func handleDone(_ sender: UIBarButtonItem) {
        guard let name = textFieldName.text, textFieldName.hasText else {
            print("El nombre es requerido")
            return
        }
        
        guard let stars = textFieldStars.text, textFieldStars.hasText else {
            print("El numero de estrellas es requerido")
            return
        }
        
        delegate?.addPlayer(name: name, stars: stars)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
