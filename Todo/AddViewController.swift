//
//  AddViewController.swift
//  Todo
//
//  Created by 桑原佑輔 on 2021/02/10.
//

import UIKit
import FloatingPanel

class AddViewController: UIViewController,UITextFieldDelegate {
    //
    var fpc = FloatingPanelController()
    var toolBar:UIToolbar!
    var datePicker: UIDatePicker = UIDatePicker()
    
    @IBOutlet weak var deadLineTextField: UITextField!
    
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
