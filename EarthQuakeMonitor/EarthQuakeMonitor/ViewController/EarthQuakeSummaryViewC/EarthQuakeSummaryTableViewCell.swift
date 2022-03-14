//
//  EarthQuakeSummaryTableViewCell.swift
//  EarthQuakeMonitor
//
//  Created by Ruchin Singhal on 23/02/22.
//

import UIKit

class EarthQuakeSummaryTableViewCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configureCell(withEarthQuakeFeature earthQuakeFeature: EarthQuakeFeature, forIndexPath indexPath: IndexPath) {
    
    self.backgroundColor = .white
    
    var configuration = UIListContentConfiguration.subtitleCell()
    configuration.text = earthQuakeFeature.properties.place
    configuration.secondaryText = "\(earthQuakeFeature.properties.mag)"
    self.contentConfiguration = configuration
    
    switch earthQuakeFeature.properties.mag {
    case 0.0...0.9:
      self.backgroundColor = UIColor.alertGreenColor()
    case 1.0...4.9:
      self.backgroundColor = UIColor.alertYellowColor()
    case 5.0...8.9:
      self.backgroundColor = UIColor.alertOrangeColor()
    case 9.0...9.9:
      self.backgroundColor = UIColor.alertRedColor()
    default:
      break
    }
  }
}
