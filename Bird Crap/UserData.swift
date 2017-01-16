//
//  UserData.swift
//  Bird Crap
//
//  Created by Rick Crane on 16/01/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import Firebase

class UserData {
        private let dataBaseURL = "https://my-granpa.firebaseio.com/"
    
    init(){
        
        
        
        
    }
    
    func setUserName(name : String){
        let ref = FIRDatabase.database().reference(fromURL: dataBaseURL)
        ref.updateChildValues(["SomeValue" : 123123])
        
        
        //self.ref.child("users").setValue(["username": name])
    }
}
