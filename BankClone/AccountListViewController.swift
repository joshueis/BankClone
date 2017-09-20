//
//  AccountListViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Israel Carvajal on 8/10/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class AccountListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var accounts = [AccountM]()
    var atRow = Int()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("account list loaded")
        
        let acccountQry = PFQuery(className: "account")
        //get the accounts for current user
        acccountQry.whereKey("accountHolder", equalTo: (PFUser.current()?.objectId!)!)
        //acccountQry.selectKeys(["objectId"])
        acccountQry.findObjectsInBackground(block: { (objects, error) in
            DispatchQueue.global(qos: .background).async { //keep fetching in the background, different thread
                if let accounts = objects {
                    for object in accounts{
                        if let account = object as? PFObject{
                            
                            let accountId = account.objectId!
                            let name = account["accountName"] as! String
                            let num =  String(account["accountNumber"] as! NSInteger)
                            let type = account["type"] as! String
                            let bal = account["bal"] as! Float
                            let a = AccountM(id:accountId, name: name, number: num, type: type, bal: bal)
                            
                            self.accounts.append(a)
                            print("done with qry")
                            DispatchQueue.main.async {
                                print("realoading data")
                                self.tableView.reloadData()
                            }
                        }
                    }
                    //print(accounts)
                }
            }
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
       
        return accounts.count
       
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AccountDetailsTableViewCell
        
        cell.accountName.text = accounts[indexPath.row].name
        
        cell.accountNumber.text = "..." + accounts[indexPath.row].number
        
        cell.amount.text = String(accounts[indexPath.row].balance)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        atRow = indexPath.row
        performSegue(withIdentifier: "toTransaction", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTransaction" {
            if let viewController = segue.destination as? TransactionViewController {
                viewController.account = self.accounts[atRow]
            }
        }
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
