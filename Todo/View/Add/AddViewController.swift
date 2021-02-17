//
//  AddViewController.swift
//  Todo
//
//  Created by 桑原佑輔 on 2021/02/10.
//

import UIKit
import FloatingPanel
@testable import RealmSwift

class AddViewController: UIViewController,UITextFieldDelegate {
    //
    var fpc = FloatingPanelController()
    var toolBar:UIToolbar!
    var datePicker: UIDatePicker = UIDatePicker()
    
    //class makeId: Object {
    //
    //    @objc dynamic var id : String = NSUUID().uuidString
    //    @objc dynamic var createAt = Date()
    // IDをプライマリキーにする
    //        override static func primaryKey() -> String? {
    //            return "id"
    //        }
    //    }
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDetail: UITextField!
    @IBOutlet weak var deadLineTextField: UITextField!
    
    @IBAction func saveBottonTapped(_ sender: Any) {
        let todoModel:TodoModel = TodoModel()
        todoModel.taskTitle = self.taskTitle.text!
        todoModel.taskDetail = self.taskDetail.text!
//        todoModel.taskDeadline = dateFromString(string: deadLineTextField.text!, format: "yyyy/MM/dd HH:mm")
        todoModel.id =  NSUUID().uuidString
        let realm = try! Realm()
        try! realm.write {
            realm.add(todoModel)
        }
        
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    func dateFromString(string: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deadLineTextField.delegate = self
        setupToolbar()
        
    }
    func setupToolbar() {
        //datepicker上のtoolbarのdoneボタン
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(doneBtn))
        toolBar.items = [toolBarBtn]
        deadLineTextField.inputAccessoryView = toolBar
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        let datePickerView:UIDatePicker = UIDatePicker()
        //        datePickerView.datePickerMode = UIDatePicker.Mode.date
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
    }
    
    //datepickerが選択されたらtextfieldに表示
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        dateFormatter.locale  = NSLocale(localeIdentifier: "ja_JP") as Locale?
        deadLineTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    //toolbarのdoneボタン
    @objc func doneBtn(){
        deadLineTextField.resignFirstResponder()
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

//ボタンを押す→
