//
//  gameTableViewCell.swift
//  Tadak
//
//  Created by Kang Minsang on 2021/01/17.
//

import UIKit
import Firebase

class gameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameLabel: UILabel!
    
    
    var mainTitleString = ""
    var dataSource : String = ""
    var ref:DatabaseReference!

    override func awakeFromNib() {
        super.awakeFromNib()
        ref = Database.database().reference()
    }

    @IBAction func cellSelected(_ sender: UIButton) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
