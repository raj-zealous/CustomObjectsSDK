//
//  TextViewTblCell.swift
//  CustomObjectsSDK
//
//  Created by Deepak Tagadiya on 15/04/22.
//

import UIKit

class TextViewTblCell: UITableViewCell {
    
    //MARK: - outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtViewValue: UITextView!
    @IBOutlet weak var cellBGView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addDoneButtonOnKeyboard()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

        self.txtViewValue.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.txtViewValue.resignFirstResponder()
    }
}
