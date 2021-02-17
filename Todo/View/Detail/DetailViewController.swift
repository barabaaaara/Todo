//
//  DetailViewController.swift
//  Todo
//
//  Created by 桑原佑輔 on 2021/02/10.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var todo: TodoModel = TodoModel()
    var suuji: Int = 0
    var editBarButtonItem: UIBarButtonItem!
    var todos: [TodoModel]!

    @IBOutlet weak var detailtitle: UITextField!
    @IBOutlet weak var detailDetail: UITextField!
    @IBOutlet weak var deadline: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        editBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBarButtonTapped(_:)))

        self.navigationItem.rightBarButtonItems = [editBarButtonItem]
        
        detailtitle.text = todo.taskTitle
        detailDetail.text = todo.taskDetail
        //        deadline.text = todo.taskDeadline?.description
        
        
    }
    @objc func editBarButtonTapped(_ sender: UIBarButtonItem) {
        let realm = try! Realm()
        //viewControllerのidをStringにする
        let id = todo.id.description
        
        //全件取得してidでfilterして更新対象を取得
        self.todos = Array(realm.objects(TodoModel.self).filter("id == %@", id))
        do{
          try realm.write{
            //更新したtextFieldの値をtodosの0番目に代入
            self.todos[0].taskTitle = detailtitle.text!
            self.todos[0].taskDetail = detailDetail.text!
          }
        }catch {
          print("Error \(error)")
        }
        //navigationControllerのpushで遷移していたので、popViewControllerでもどる
        self.navigationController?.popViewController(animated: true)

        
        
    }
    
    
}
