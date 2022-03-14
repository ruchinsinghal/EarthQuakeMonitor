//
//  EarthQuakeSummaryViewModel.swift
//  EarthQuakeMonitor
//
//  Created by Ruchin Singhal on 23/02/22.
//

import Foundation

class EarthQuakeSummaryViewModel {
  
  //MARK: - ----------Public Variables---------- -
  var earthQuakeSummary: EarthQuakeSummary!
  
  //MARK: - ----------WebService Methods---------- -
  func callGetEarthQuakeSummary(_ completionClosure: @escaping () -> ()) {
  
    let dictParams = [KeyConstants.kEndTime: Date(),
                      KeyConstants.kStartTime: Date().addingTimeInterval(-3600)]
    
    NetworkManager.shared.requestAPI(withName: WebServiceName.kEarthQuakeSummary, requestMethod: .get, requestParameters: dictParams, withDecodable: EarthQuakeSummary.self) { result, error, statusCode in
      self.earthQuakeSummary = result
      completionClosure()
    }
  }
}
