//
//  ReportingKnob.swift
//  Droar
//
//  Created by Nathan Jangula on 10/16/17.
//

import Foundation

internal class ReportingKnob : DroarKnob {
    
    private enum ReportingRow: Int {
        case screenshot = 0
        case dump = 1
        case count = 2
    }
    
    func droarKnobTitle() -> String {
        return "Reporting"
    }
    
    func droarKnobPosition() -> PositionInfo {
        return PositionInfo(position: .middle, priority: .low)
    }
    
    func droarKnobNumberOfCells() -> Int {
        return ReportingRow.count.rawValue
    }
    
    func droarKnobCellForIndex(index: Int, tableView: UITableView) -> DroarCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DroarLabelCell") as? DroarLabelCell ?? DroarLabelCell.create()
        cell.selectionStyle = .gray

        switch ReportingRow(rawValue:index)! {
        case .screenshot:
            cell.titleLabel.text = "Screenshot"
            cell.detailLabel.text = ""
        case .dump:
            cell.titleLabel.text = "Generate Current State Dump"
            cell.detailLabel.text = ""
        case .count:
            cell.titleLabel.text = ""
            cell.detailLabel.text = ""
        }
        
        return cell
    }
    
    func droarKnobIndexSelected(tableView: UITableView, selectedIndex: Int) {
        switch ReportingRow(rawValue: selectedIndex)! {
        case .screenshot:
            if let image = Droar.captureScreen() {
                let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                Droar.present(activityVC, animated: true, completion: nil)
            }
        case .dump:
            let dump = KnobManager.sharedInstance.generateStateDump()
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dump, options: .prettyPrinted)
                if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    let activityVC = UIActivityViewController(activityItems: [jsonString], applicationActivities: nil)
                    Droar.present(activityVC, animated: true, completion: nil)
                }
            } catch let error {
                print(error)
            }
        default:
            break
        }
    }
}
