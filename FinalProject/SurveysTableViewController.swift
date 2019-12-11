//
//  SurveysTableViewController.swift
//  FinalProject
//
//  Created by Arun Patwardhan on 08/08/18.
//  Copyright © 2018 Amaranthine. All rights reserved.
//

import UIKit

class SurveysTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Prepare the local data structure
        for i in 0..<12
        {
            self.listData[MonthType.enumFrom(Int: i)] = [SurveyModel]()
        }
        
        //Prepare the edit button
        let editButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(SurveysTableViewController.editTapped))
        
        self.navigationItem.rightBarButtonItem = editButton
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Surveys"
        
        //Pull the data from the local DB
        dataModelHandle.pullData(UpdateScreenWith: {(responses : [Responses]) -> Void in
            for entry in responses
            {
                let newSurvey : SurveyModel = SurveyModel(name: entry.name!, dateOfBirth: entry.dob!, email: entry.email!, phone: entry.cell!, foodRating: Rating.generate(withNumber: entry.food), ambienceRating: Rating.generate(withNumber: entry.amibeince), serviceRating: Rating.generate(withNumber: entry.service), dateOfSurvey: entry.surveyDate!)
                
                self.listData[MonthType.enumFrom(Date: entry.surveyDate!)]?.append(newSurvey)
            }
            self.tableView.reloadData()
        })
    }
    
    @objc func editTapped()
    {
        let tableEditingMode = self.tableView.isEditing
        self.tableView.setEditing(!tableEditingMode, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.listData.removeAll()
    }
    
    //Variables --------------------------------------------------
    var dataModelHandle : DataModelController   = DataModelController.createModelController()
    var listData : [MonthType : [SurveyModel]]  = [MonthType : [SurveyModel]]()
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return listData.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.listData[MonthType.enumFrom(Int: section)]?.count) ?? 0
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]?
    {
        var sections : [String] = [String]()
        
        //Check to make sure that we have at least 1 entry for a given key. Only then should we send the key Name
        for i in 0..<12
        {
            guard (self.listData[MonthType.enumFrom(Int: i)]?.count) != nil
            else
            {
                continue
            }
            
            guard (self.listData[MonthType.enumFrom(Int: i)]?.count)! > 0
            else
            {
                continue
            }
            sections.append(String(MonthType.enumFrom(Int: i).toString().first!))
        }

        return sections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if self.listData[MonthType.enumFrom(Int: section)]?.count == 0
        {
            return nil
        }

        return String(MonthType.enumFrom(Int: section).toString().first!)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if nil == cell
        {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CELL")
        }
        
        let rowData : SurveyModel = self.listData[MonthType.enumFrom(Int: indexPath.section)]![indexPath.row]
        cell?.textLabel?.text = rowData.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        cell?.detailTextLabel?.text = dateFormatter.string(from: rowData.dateOfSurvey)
        return cell!
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            //1) Delete from the DB
            let rowData : SurveyModel = self.listData[MonthType.enumFrom(Int: indexPath.section)]![indexPath.row]
            dataModelHandle.delete(forName: rowData.name)
            
            //2) Delete from the table data model
            (self.listData[MonthType.enumFrom(Int: indexPath.section)])?.remove(at: indexPath.row)
            
            //3) Update UI
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let rowData = self.listData[MonthType.enumFrom(Int: indexPath.section)]![indexPath.row]
        self.performSegue(withIdentifier: "moreDetails", sender: rowData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if "moreDetails" == segue.identifier
        {
            let destination = segue.destination as? InformationViewController
            destination?.data = sender as? SurveyModel
        }
    }
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
