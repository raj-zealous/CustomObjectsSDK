//
//  TextFieldTblCell.swift
//  CustomObjectsSDK
//
//  Created by Deepak Tagadiya on 13/04/22.
//

import UIKit

class TextFieldTblCell: UITableViewCell {
    
    //MARK: - outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFieldValue: UITextField!
    @IBOutlet weak var cellBGView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addDoneButtonOnKeyboard()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
//        doneToolbar.barStyle = .blackTranslucent

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        doneToolbar.items = (items as! [UIBarButtonItem])
        doneToolbar.sizeToFit()

        self.txtFieldValue.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.txtFieldValue.resignFirstResponder()
    }
}
