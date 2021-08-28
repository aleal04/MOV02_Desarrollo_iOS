//
//  ViewController.swift
//  transitions
//
//  Created by Andrey Leal on 28/8/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func SegueTapped(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let greenViewController = mainStoryboard.instantiateViewController(
            withIdentifier: "GreenViewController") as?
                GreenViewController else{
                print("Couldn't find the view controller")
                return
        }
        
        greenViewController.modalTransitionStyle = .crossDissolve
        present(greenViewController, animated: true, completion: nil)
    }
    
}

