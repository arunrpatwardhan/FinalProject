//
//  ViewController.swift
//  FinalProject
//
//  Created by Arun Patwardhan on 08/08/18.
//  Copyright © 2018 Amaranthine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        agePicker.backgroundColor = UIColor(displayP3Red: 253.0/255.0, green: 146.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Variables --------------------------------------------------
    var dataModelHandle : DataModelController = DataModelController.createModelController()
    
    //IBOutlets --------------------------------------------------
    @IBOutlet var personalInfo: [UITextField]!
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var agePicker: UIDatePicker!
    @IBOutlet var ratingControl: [UISegmentedControl]!
    
    //IBActions --------------------------------------------------
    @IBAction func ageValueChanged(_ sender: UISlider, forEvent event: UIEvent) {
        ageLabel.text = "\(Int(sender.value))"
        
        agePicker.setDate(Date(timeIntervalSinceNow: -TimeInterval(sender.value * 365.0 * 24.0 * 60.0 * 60.0)), animated: true)
    }
    
    @IBAction func datePicked(_ sender: UIDatePicker, forEvent event: UIEvent) {
        let difference = (((sender.date.timeIntervalSinceNow / 60.0) / 60.0) / 24.0) / 365.0
        print(difference)
        
        ageLabel.text = "\(Int(-difference))"
        ageSlider.value = Float(-difference)
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem)
    {
        dataModelHandle.put()
        self.clearScreen()
    }
    
    @IBAction func historyTapped(_ sender: UIBarButtonItem) {
        self.clearScreen()
    }
    
    @IBAction func addToCacheTapped(_ sender: UIBarButtonItem)
    {
        let newSurvey : SurveyModel = SurveyModel(name: personalInfo[0].text!, dateOfBirth: agePicker.date, email: personalInfo[2].text!, phone: personalInfo[1].text!, foodRating: Rating.generate(withNumber: Int16(ratingControl[0].selectedSegmentIndex)) , ambienceRating: Rating.generate(withNumber: Int16(ratingControl[1].selectedSegmentIndex)), serviceRating: Rating.generate(withNumber: Int16(ratingControl[2].selectedSegmentIndex)), dateOfSurvey: Date(timeIntervalSinceNow: 0))
        dataModelHandle.cache(Survey: newSurvey)
        self.clearScreen()
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.clearScreen()
    }
    
    //Functions
    func clearScreen()
    {
        ageSlider.value = 0.0
        agePicker.setDate(Date(timeIntervalSinceNow: 0), animated: true)
        ageLabel.text = "0"
        
        personalInfo[0].text = ""
        personalInfo[1].text = ""
        personalInfo[2].text = ""
        
        ratingControl[0].selectedSegmentIndex = 0
        ratingControl[1].selectedSegmentIndex = 0
        ratingControl[2].selectedSegmentIndex = 0
    }
    
}

