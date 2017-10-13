//
//  BuildInfoSource.swift
//  Droar
//
//  Created by Nathan Jangula on 10/11/17.
//

import Foundation

internal class BuildInfoSource : IDroarSource {
    
    private enum BuildInfoRow: Int {
        case name = 0
        case displayName = 1
        case versionNumber = 2
        case buildNumber = 3
        case buildDate = 4
        case buildTime = 5
        case bundleId = 6
        // TODO Remove supportedPlatforms?
        case supportedPlatforms = 7
        case minimumOSVersion = 8
        case supportedOrientations = 9
        case count = 10
    }
    
    func droarSectionTitle() -> String {
        return "Build Info"
    }
    
    func droarSectionPosition() -> PositionInfo {
        return PositionInfo(position: .bottom, priority: .low)
    }
    
    func droarSectionNumberOfCells() -> Int {
        return BuildInfoRow.count.rawValue
    }
    
    func droarSectionCellForIndex(index: Int, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DroarLabelCell") as? DroarLabelCell ?? DroarLabelCell.create()
        
        let info = Bundle.main.infoDictionary
        
        switch BuildInfoRow(rawValue:index)! {
        case .name:
            cell.titleLabel.text = "Name"
            cell.detailLabel.text = info?["CFBundleName"] as? String
        case .displayName:
            cell.titleLabel.text = "Display Name"
            cell.detailLabel.text = info?["CFBundleDisplayName"] as? String ?? info?["CFBundleName"] as? String
        case .versionNumber:
            cell.titleLabel.text = "Version Number"
            cell.detailLabel.text = info?["CFBundleShortVersionString"] as? String
        case .buildNumber:
            cell.titleLabel.text = "Build Number"
            cell.detailLabel.text = info?["CFBundleVersion"] as? String
        case .buildDate:
            cell.titleLabel.text = "Build Date"
            cell.detailLabel.text = compileDate()
        case .buildTime:
            cell.titleLabel.text = "Build Time"
            cell.detailLabel.text = compileTime()
        case .bundleId:
            cell.titleLabel.text = "Bundle ID"
            cell.detailLabel.text = info?["CFBundleIdentifier"] as? String
        case .supportedPlatforms:
            cell.titleLabel.text = "Supported Platforms"
            cell.detailLabel.text = info?["CFBundleSupportedPlatforms"] as? String
        case .minimumOSVersion:
            cell.titleLabel.text = "Minimum OS Version"
            cell.detailLabel.text = info?["MinimumOSVersion"] as? String
        case .supportedOrientations:
            cell.titleLabel.text = "Orientations"
            
            if let orientations = info?["UISupportedInterfaceOrientations"] as? [String] {
                cell.detailLabel.text = orientations.joined(separator: ", ")
            }
            else
            {
                cell.detailLabel.text = ""
            }
        case .count:
            cell.titleLabel.text = ""
            cell.detailLabel.text = ""
        }
        
        return cell
    }
}
