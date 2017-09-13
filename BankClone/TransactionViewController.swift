//
//  TransactionViewController.swift
//  BankClone
//
//  Created by Israel Carvajal on 8/12/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class TransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var balanceTL: UILabel!
    @IBOutlet weak var accountNameL: UILabel!
    @IBOutlet weak var transTable: UITableView!
    var account = AccountM()
    var transactions = [TransactionM]()
    override func viewDidLoad() {
        super.viewDidLoad()
        accountNameL.text = account.name
        balanceTL.text = String(account.balance)
        getTransactions()
        // Do any additional setup after loading the view.
    }
    
    func getTransactions(){
        let tranQry = PFQuery(className: "transaction")
        //get the transactions for current account
        print(account.id)
        tranQry.whereKey("accountId", equalTo: account.id)
        //acccountQry.selectKeys(["objectId"])
        tranQry.findObjectsInBackground(block: { (objects, error) in
            
            if let trans = objects {
                for object in trans{
                    if let tran = object as? PFObject{
                       // print(tran)
                        let description = tran["description"] as! String
                        let amount = tran["amount"] as! Float
                        let date = tran.updatedAt
                        let credit = tran["credit"] as! Bool
                        
                        let a = TransactionM(description:description, amount: amount, date: date! as NSDate,credit:credit)
                        
                        self.transactions.append(a)
                        
                        self.transTable.reloadData()
                    }
                }
                
            }
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transactions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransactionViewCell
        
        cell.amountTL.text = transactions[indexPath.row].amount.description
        cell.descriptionTL.text = transactions[indexPath.row].description
        cell.dateTL.text = String(transactions[indexPath.row].date.description.characters.prefix(10))
                
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

 


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
