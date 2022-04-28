//
//  SectionHeaderTblCell.swift
//  CustomObjectsSDK
//
//  Created by Deepak Tagadiya on 13/04/22.
//

import UIKit

public class SectionHeaderTblCell: UITableViewCell {
    
    //MARK: - outlet
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var sectionCellBGView: UIView!

    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
