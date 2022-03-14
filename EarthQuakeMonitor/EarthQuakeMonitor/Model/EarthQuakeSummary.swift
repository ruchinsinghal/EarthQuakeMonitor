//
//  EarthQuakeSummary.swift
//  EarthQuakeMonitor
//
//  Created by Ruchin Singhal on 23/02/22.
//

import Foundation

struct EarthQuakeSummary: Decodable {
  let type: String
  let metadata: EarthQuakeMetaData
  let features: [EarthQuakeFeature]
  let bbox: [Double]
  
  enum CodingKeys: String, CodingKey {
    case type
    case metadata
    case features
    case bbox
  }
}

struct EarthQuakeMetaData: Decodable {
  let generated: Double
  let url: String
  let title: String
  let status: Double
  let api: String
  let count: Double
  
  enum CodingKeys: String, CodingKey {
    case generated
    case url
    case title
    case status
    case api
    case count
  }
}

struct EarthQuakeFeature: Decodable {
  let type: String
  let properties: EarthQuakeFeatureProperties
  let geometry: EarthQuakeFeatureGeometry
  let id: String
  
  enum CodingKeys: String, CodingKey {
    case type
    case properties
    case geometry
    case id
  }
}

struct EarthQuakeFeatureProperties: Decodable {
  let mag: Double
  let place: String
  let time: Double
  let updated: Double?
  let tz: String?
  let url: String?
  let detail: String?
  let felt: Double?
  let cdi: Double?
  let mmi: Double?
  let alert: String?
  let status: String?
  let tsunami: Double?
  let sig: Double?
  let net: String?
  let code: String?
  let ids: String?
  let sources: String?
  let types: String?
  let nst: Double?
  let dmin: Double?
  let rms: Double?
  let gap: Double?
  let magType: String?
  let type: String?
  let title: String
  
  enum CodingKeys: String, CodingKey {
    case mag
    case place
    case time
    case updated
    case tz
    case url
    case detail
    case felt
    case cdi
    case mmi
    case alert
    case status
    case tsunami
    case sig
    case net
    case code
    case ids
    case sources
    case types
    case nst
    case dmin
    case rms
    case gap
    case magType
    case type
    case title
  }
}

struct EarthQuakeFeatureGeometry: Decodable {
  let type: String
  let coordinates: [Double]
  
  enum CodingKeys: String, CodingKey {
    case type
    case coordinates
  }
}
