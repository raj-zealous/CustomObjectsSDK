//
//  AlertRowTblCell.swift
//  CustomObjectsSDK
//
//  Created by Deepak Tagadiya on 15/04/22.
//

import UIKit

class AlertRowTblCell: UITableViewCell {

    //MARK: - outlet
    @IBOutlet weak var optionCellBGView: UIView!
    @IBOutlet weak var lblOptionTitle: UILabel!
    @IBOutlet weak var lblOptionValue: UILabel!
    @IBOutlet weak var btnOpenAlertAction: UIControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
