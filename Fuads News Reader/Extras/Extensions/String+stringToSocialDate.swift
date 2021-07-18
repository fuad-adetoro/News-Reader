//
//  String+stringToSocialDate.swift
//  Fuads News Reader
//
//  Created by FA on 18/07/2021.
//

import UIKit

extension String {
    func stringToSocialDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        
        var dateString = ""
        
        if let timeAgoText = dateFormatter.date(from: self) {
            dateString = timeAgoText.timeAgoDisplay()
        } else {
            dateString = ""
        }
        
        return dateString
    }
}
