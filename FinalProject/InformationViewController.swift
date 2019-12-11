//
//  InformationViewController.swift
//  FinalProject
//
//  Created by Arun Patwardhan on 08/08/18.
//  Copyright © 2018 Amaranthine. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBOutlets --------------------------------------------------
    @IBOutlet var informationLabels: [UILabel]!
    
    //Variables --------------------------------------------------
    var data : SurveyModel?
    
    override func viewWillAppear(_ animated: Bool) {
        informationLabels[0].text = data?.name
        informationLabels[1].text = data?.email
        informationLabels[3].text = "\((data?.foodRating)!)"
        informationLabels[4].text = "\((data?.ambienceRating)!)"
        informationLabels[5].text = "\((data?.serviceRating)!)"
        
        let dateFormatter       = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        informationLabels[2].text = dateFormatter.string(from: (data?.dateOfBirth)!)
        informationLabels[6].text = dateFormatter.string(from: (data?.dateOfSurvey)!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
