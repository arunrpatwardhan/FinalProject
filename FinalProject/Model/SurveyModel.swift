//
//  SurveyModel.swift
//  FinalProject
//
//  Created by Arun Patwardhan on 08/08/18.
//  Copyright © 2018 Amaranthine. All rights reserved.
//

import Foundation

/**
This struct represents a single Response from the customer.
 
 - Author: Arun Patwardhan
 - Version: 1.0
 */
struct SurveyModel
{
    var name            : String
    var dateOfBirth     : Date
    var email           : String
    var phone           : String
    var foodRating      : Rating
    var ambienceRating  : Rating
    var serviceRating   : Rating
    var dateOfSurvey    : Date
}

extension SurveyModel : Equatable
{
    static func ==(lhs : SurveyModel, rhs : SurveyModel) -> Bool
    {
        print(lhs)
        return (lhs.name == rhs.name) &&
            (lhs.ambienceRating == rhs.ambienceRating) &&
            (lhs.dateOfBirth == rhs.dateOfBirth) &&
            (lhs.dateOfSurvey == rhs.dateOfSurvey) &&
            (lhs.email == rhs.email) &&
            (lhs.foodRating == rhs.foodRating) &&
            (lhs.phone == rhs.phone)
    }
}
