//
//  TableViewCell.swift
//  Todo
//
//  Created by 桑原佑輔 on 2021/02/10.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func (_ sender: UIBarButtonItem) {
//        let detailVC = DetailViewController()
//        detailVC.modalPresentationStyle = .fullScreen // ★この行追加
//        self.present(detailVC, animated: true, completion: nil)
//    }
}
