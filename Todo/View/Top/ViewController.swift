//
//  ViewController.swift
//  Todo
//
//  Created by 桑原佑輔 on 2021/02/10.
//

import UIKit
import FloatingPanel
import RealmSwift

class ViewController: UIViewController,FloatingPanelControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var todos: [TodoModel]!
    var addBarButtonItem: UIBarButtonItem!
    var fpc = FloatingPanelController()
    var notificationToken: NotificationToken? = nil
    
    
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
        
        let realm = try! Realm()
        
        
        self.todos = Array(realm.objects(TodoModel.self))
        print(self.todos.count)
        
        
        notificationToken = realm.objects(TodoModel.self).observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update:
                print("update")
                self!.todos = Array(realm.objects(TodoModel.self))
                tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentingViewController?.beginAppearanceTransition(false, animated: animated)
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
        let realm = try! Realm()
        
        self.todos = Array(realm.objects(TodoModel.self))
        tableView.reloadData()
    }
    
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let contentVC = AddViewController()
        fpc.set(contentViewController: contentVC)
        fpc.layout = MyFloatingPanelLayout()
        fpc.isRemovalInteractionEnabled = true
        self.present(fpc, animated: true, completion: nil)
    }
    
    //    @IBAction func (_ sender: UIBarButtonItem) {
    //        let detailVC = DetailViewController()
    //        detailVC.modalPresentationStyle = .fullScreen // ★この行追加
    //        self.present(detailVC, animated: true, completion: nil)
    //    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Registers a class for use in creating new table cells.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let todo: TodoModel = self.todos[(indexPath as NSIndexPath).row];
        
        cell.taskLabel.text = todo.taskTitle
        
        print(indexPath.row)
        return cell
    }
    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //    スワイプしたセルを削除　※arrayNameは変数名に変更してください
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let realm = try! Realm()
            print(self.todos.count)
            print(indexPath.row)
            try! realm.write {realm.delete(todos[indexPath.row])
                self.todos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
                
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let todo: TodoModel = self.todos[indexPath.row];
        let vc = DetailViewController()
        vc.todo = todo
        vc.suuji = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
    CGFloat {
        return 100
    }
}
extension ViewController: UITableViewDataSource{ }
class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 180.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}
