//
//  TableViewCell.swift
//  ScanQR
//
//  Created by Kurniawan Gigih Lutfi Umam on 12/05/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblMerchanName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
