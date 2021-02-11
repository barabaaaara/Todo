//
//  ViewController.swift
//  Todo
//
//  Created by 桑原佑輔 on 2021/02/10.
//

import UIKit
import FloatingPanel

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FloatingPanelControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Registers a class for use in creating new table cells.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.taskLabel.text = TODO[indexPath.row]
        print(indexPath.row)
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var TODO = ["勉強する","起きる","ご飯作る",]
    var addBarButtonItem: UIBarButtonItem!
    var fpc = FloatingPanelController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        tableView.delegate = self
        tableView.dataSource = self
        //Registers a class for use in creating new table cells.
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"TableViewCell")
        fpc.delegate = self
        
        self .navigationItem.title = "メイン"
        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
 
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let contentVC = AddViewController()
        fpc.set(contentViewController: contentVC)
        fpc.layout = MyFloatingPanelLayout()
        fpc.isRemovalInteractionEnabled = true
        self.present(fpc, animated: true, completion: nil)
    }
    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //スワイプしたセルを削除　※arrayNameは変数名に変更してください
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            TODO.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
    CGFloat {
        return 100
    }
    
//    画面遷移は２種類ある→プッシュ遷移・モーダル遷移の二つ
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
      return [
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 180.0, edge: .bottom, referenceGuide: .safeArea),
      ]
    }
  }
