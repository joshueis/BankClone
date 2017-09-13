//
//  TransactionM.swift
//  BankClone
//
//  Created by Israel Carvajal on 8/12/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

struct TransactionM{
    
    
    var description : String
    var amount : Float
    var date : NSDate
    var credit : Bool
    init(description:String, amount: Float, date: NSDate, credit:Bool = false){
        self.description = description
        self.amount = amount
        self.date = date
        self.credit = credit
    }
    
    init(){
        self.description = ""
        self.amount = Float()
        self.date = NSDate()
        self.credit = false
    }

    
}
