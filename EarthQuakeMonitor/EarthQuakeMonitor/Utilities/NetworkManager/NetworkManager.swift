//
//  NetworkManager.swift
//  EarthQuakeMonitor
//
//  Created by Ruchin Singhal on 23/02/22.
//

import Foundation
import Alamofire

class NetworkManager {
  
  let BASE_URL = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/"
  
  static let shared: NetworkManager = {
    return NetworkManager()
  }()
  
  func requestAPI<T: Decodable>(withName apiName: String, requestMethod method: HTTPMethod, requestParameters params: Dictionary<String, Any>, withDecodable decodable: T.Type, completionClosure:@escaping (_ result: T?, _ error: Error?, _ statusCode: Int) -> ()) {
    
    if NetworkReachabilityManager()?.isReachable == true {
      
      let headers = getHeader()
      let serviceUrl = getServiceUrl(withAPIName: apiName)
      
      switch method {
      case .get:
        AF.request(serviceUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseDecodable(of: T.self) { dataResponse in
          switch dataResponse.result {
          case .success:
            let response = self.getResultFromResponse(dataResponse, withDecodable: decodable)
            completionClosure(response.responseData, dataResponse.error, dataResponse.response?.statusCode ?? 000)
          case .failure(let error):
            completionClosure(nil, error, dataResponse.response?.statusCode ?? 000)
          }
        }
      case .post:
        AF.request(serviceUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: T.self) { dataResponse in
          switch dataResponse.result {
          case .success:
            let response = self.getResponseDataDictionaryFromData(data: dataResponse.data!, withDecodable: decodable)
            completionClosure(response.responseData, response.error, dataResponse.response?.statusCode ?? 000)
          case .failure(let error):
            completionClosure(nil, error, dataResponse.response?.statusCode ?? 000)
          }
        }
      default:
        completionClosure(nil, nil, 500)
      }
    } else {
      completionClosure(nil, nil, 500)
    }
  }
  
  private func getHeader() -> HTTPHeaders {
    
    var headers: HTTPHeaders = []
    headers.add(HTTPHeader.init(name: "Content-Type", value: "application/json"))
    return headers
  }
  
  private func getServiceUrl(withAPIName apiName: String) -> String {
    return BASE_URL + apiName
  }
  
  private func getResultFromResponse<T: Decodable>(_ dataResponse: DataResponse<T, AFError>, withDecodable decodable: T.Type) -> (responseData: T?, error: Error?) {
    do {
      let responseData = try dataResponse.result.get()
      return (responseData, nil)
    }
    catch let error {
      return (nil, error)
    }
  }
  
  private func getResponseDataDictionaryFromData<T: Decodable>(data: Data, withDecodable decodable: T.Type) -> (responseData: T?, error: Error?) {
    do {
      guard let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? T else {
        return (nil, nil)
      }
      return (responseData, nil)
    }
    catch let error {
      return (nil, error)
    }
  }
}
