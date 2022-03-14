//
//  EarthQuakeListViewC.swift
//  EarthQuakeMonitor
//
//  Created by Ruchin Singhal on 23/02/22.
//

import UIKit
import SVPullToRefresh

class EarthQuakeSummaryViewC: UIViewController {
  
  private let earthQuakeSummaryViewModel = EarthQuakeSummaryViewModel()
  
  @IBOutlet weak var tblViewSummary: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  private func configureView() {
    refreshViewData()
    
    tblViewSummary.addPullToRefresh {
      self.refreshViewData()
    }
  }
  
  private func refreshViewData() {
    earthQuakeSummaryViewModel.callGetEarthQuakeSummary {
      if self.tblViewSummary.showsPullToRefresh {
        self.tblViewSummary.pullToRefreshView.stopAnimating()
      }
      self.tblViewSummary.reloadData()
    }
  }
  
  @IBAction func tapRefresh(_ sender: UIButton) {
    refreshViewData()
  }
}

extension EarthQuakeSummaryViewC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if earthQuakeSummaryViewModel.earthQuakeSummary == nil { return 0 }
    return earthQuakeSummaryViewModel.earthQuakeSummary.features.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let earthQuakeSummaryTableViewCell = tblViewSummary.dequeueReusableCell(withIdentifier: EarthQuakeSummaryTableViewCell
                                                                              .identifier(), for: indexPath) as! EarthQuakeSummaryTableViewCell
    earthQuakeSummaryTableViewCell.configureCell(withEarthQuakeFeature: earthQuakeSummaryViewModel.earthQuakeSummary.features[indexPath.row], forIndexPath: indexPath)
    return earthQuakeSummaryTableViewCell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 56.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: StoryboardConstants.kMain, bundle: nil)
    let earthQuakeDetailViewC = storyboard.instantiateViewController(withIdentifier: EarthQuakeDetailViewC.identifier()) as! EarthQuakeDetailViewC
    earthQuakeDetailViewC.earthQuakeDetailViewModel.earthQuakeFeature = earthQuakeSummaryViewModel.earthQuakeSummary.features[indexPath.row]
    navigationController?.pushViewController(earthQuakeDetailViewC, animated: true)
  }
}
