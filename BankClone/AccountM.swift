//
//  AccountM.swift
//  BankClone
//
//  Created by Israel Carvajal on 8/12/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation
import UIKit

struct AccountM{
    var name : String
    var number : String
    var type : String
    var balance : Float
    var id : String
    init(id:String, name:String, number: String, type:String, bal:Float){
        self.name = name
        self.number = String(number.characters.suffix(4))
        self.type = type
        self.balance = bal
        self.id = id
    }
    
    init(){
        self.id = ""
        self.name = ""
        self.number = ""
        self.type = ""
        self.balance = Float()
    }
    
}


