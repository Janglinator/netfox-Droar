//
//  DroarTextFieldCell.swift
//  Droar
//
//  Created by Nathan Jangula on 10/26/17.
//

import Foundation

public class DroarTextFieldCell : UITableViewCell, DroarCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    var onTextChanged: ((String?)-> Void)?
    
    public static func create(title: String? = "", placeholder: String? = "", text: String? = "", allowSelection: Bool = false, onTextChanged: ((String?)-> Void)? = nil) -> DroarTextFieldCell {
        var cell: DroarTextFieldCell?
        
        for view in Bundle.podBundle.loadNibNamed("DroarTextFieldCell", owner: self, options: nil) ?? [Any]() {
            if view is DroarTextFieldCell {
                cell = view as? DroarTextFieldCell
            }
        }
        
        cell?.titleLabel.text = title
        cell?.textField.placeholder = placeholder
        cell?.textField.text = text
        cell?.selectionStyle = allowSelection ? .gray : .none
        cell?.onTextChanged = onTextChanged
        
        return cell ?? DroarTextFieldCell()
    }
    
    @IBAction func handleTextChanged(_ sender: Any) {
        guard let onTextChanged = onTextChanged else { return }
        onTextChanged(textField.text)
    }
    
    public func stateDump() -> [String : String]? {
        guard let text = titleLabel.text, let enteredText = textField.text else { return nil }
        return [text : enteredText]
    }
}
