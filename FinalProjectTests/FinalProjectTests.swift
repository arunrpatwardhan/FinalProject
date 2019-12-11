//
//  FinalProjectTests.swift
//  FinalProjectTests
//
//  Created by Arun Patwardhan on 29/11/19.
//  Copyright © 2019 Amaranthine. All rights reserved.
//

import XCTest
@testable import FinalProject

//This class will be used to test the model
class FinalProjectTests: XCTestCase {
    
    //Variables --------------------------------------------------
    var dataModelHandle : DataModelController!
    var newSurvey       : SurveyModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataModelHandle = DataModelController.createModelController()
        newSurvey       = SurveyModel(name              : "Arun Patwardhan",
                                      dateOfBirth       : Date(timeIntervalSince1970: 74537845399),
                                      email             : "arun@amaranthine.co.in",
                                      phone             : "9876543210",
                                      foodRating        : Rating.Acceptable,
                                      ambienceRating    : Rating.Average,
                                      serviceRating     : Rating.Excellent,
                                      dateOfSurvey      : Date(timeIntervalSinceNow: 0))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataModelHandle     = nil
        newSurvey           = nil
    }
    
    /**
     This function tests whether the data is added to the queue successfully.
     - important: This function does not test if the data is added to the persistent store.
     - returns: Void.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     - date: 29th November 2019
     */
    func testAddToCache()
    {
        dataModelHandle.cache(Survey: newSurvey)
        
        XCTAssertEqual(newSurvey, dataModelHandle.localCache.first)
    }
    
    /**
     This function tests whether the data added to the queue is successfully written to the persistent store.
     - important: This function does not test if the data is added to the persistent store.
     - returns: Void.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     - date: 29th November 2019
     */
    func testDBWrite()
    {
        dataModelHandle.cache(Survey: newSurvey)
        
        dataModelHandle.put()
    }
    
    /**
     This function tests whether the data added to the queue is successfully written to the persistent store.
     - important: This function does not test if the data is added to the persistent store.
     - returns: Void.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     - date: 29th November 2019
     */
    func testDBRead()
    {
        let myExpectation = XCTestExpectation(description: "Fetched Data")
        
        dataModelHandle.pullData(UpdateScreenWith: {(responses : [Responses]) -> Void in
            let responseSurvey : SurveyModel = SurveyModel(name             : "xyz",//responses[0].name!,
                dateOfBirth      : responses[0].dob!,
                email            : responses[0].email!,
                phone            : responses[0].cell!,
                foodRating       : Rating.generate(withNumber: responses[0].food),
                ambienceRating   : Rating.generate(withNumber: responses[0].amibeince),
                serviceRating    : Rating.generate(withNumber: responses[0].service),
                dateOfSurvey     : responses[0].surveyDate!)
            
            let responseSurvey1 : SurveyModel = SurveyModel(name             : responses[0].name!,
                dateOfBirth      : responses[0].dob!,
                email            : responses[0].email!,
                phone            : responses[0].cell!,
                foodRating       : Rating.generate(withNumber: responses[0].food),
                ambienceRating   : Rating.generate(withNumber: responses[0].amibeince),
                serviceRating    : Rating.generate(withNumber: responses[0].service),
                dateOfSurvey     : responses[0].surveyDate!)
            
            if responseSurvey != responseSurvey1
            {
                XCTFail("The read was not successful")
            }
            else
            {
                myExpectation.fulfill()
            }
        })
        wait(for: [myExpectation], timeout: 5)
    }
    
    func testWritePerformance()
    {
        dataModelHandle.cache(Survey: newSurvey)
        
        measure {
            dataModelHandle.put()
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
