//
//  Date + Extension.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 2.05.2022.
//

import Foundation

extension String {
    func convertDateFormat() -> String{
        return convertDateFormater(self ,format: "dd.MM.yyyy")
    }
    
    func convertDateFormater(_ date: String,format:String = "yyyy-MM-dd") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = format
        return  dateFormatter.string(from: date!)

    }
    func convertYearFormat() -> String{
        return convertDateFormater(self ,format: "yyyy")
    }
}

