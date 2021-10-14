//
//  UserSessiom.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 7/10/21.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

class UserSession: ObservableObject {
     
    var didChange = PassthroughSubject<UserSession , Never>()
    
    @Published var session: User? {
        didSet{
            self.didChange.send(self)
        }
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({
            (auth , user) in
            
            if let user = user {
                let firestoreUserID = AuthService.getUserId(userId: user.uid)
                firestoreUserID.getDocument{
                    (document , error) in
                    if let dict = document?.data(){
                        guard let decoderUser = try? User.init(fromDictionary: dict) else { return }
                        self.session = decoderUser
                    }
                }
            }
            else{
                self.session = nil
            }
        })
    }
    
    func logOut(){
        do{
            try Auth.auth().signOut()
        }
        catch{
            
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit{
        unbind()
    }
}
