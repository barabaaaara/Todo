//
//  AddViewController.swift
//  Todo
//
//  Created by 桑原佑輔 on 2021/02/10.
//

import UIKit
import FloatingPanel

class AddViewController: UIViewController {
    //
    var fpc = FloatingPanelController()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        let contentVC = ContentViewController()
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        
    }
    //
    
    // Do any additional setup after loading the view.
    
    class ContentViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .green
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
