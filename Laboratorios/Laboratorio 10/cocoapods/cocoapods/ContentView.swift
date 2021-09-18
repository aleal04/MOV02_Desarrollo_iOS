//
//  ContentView.swift
//  cocoapods
//
//  Created by Andrey Leal on 18/9/21.
//

import SwiftUI
import SCLAlertView

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Hello World!")
            Button(
                action:{
                    self.showAlert()
                },
                label:{
                    Text("Click Me!")
                }
            )
        }
    }
    
    func showAlert(){
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: true
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        alertView.showSuccess("No button", subTitle: "You will have hard times trying to close me")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
