//
//  SettingsViewController.swift
//  RaceStandings
//
//  Created by Constantin Koehler on 1/9/18.
//  Copyright © 2018 Constantin Koehler. All rights reserved.
//

import Foundation
import UIKit

fileprivate var newSelectedYear = Year.currentYear()

private enum SettingsCellType: Int {
    case year
    
    var cellIdentifier: String {
        switch self {
        case .year:
            return "YearSettingCell"
        }
    }
    
    var cellText: String {
        switch self {
        case .year:
            return "Year"
        }
    }
}

private struct SettingsCellModel {
    let name: String
    let action: () -> Void
}

class SettingsViewController : UITableViewController {
    
    @IBOutlet weak var yearTextField: UITextField!

    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        createToolBar()
        setUpPickerView()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Settings"
    }
    
    func setUpPickerView(){
        let pickerView = UIPickerView()

        pickerView.delegate = self
        
        yearTextField.inputView = pickerView
    }
    
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self,action: #selector(dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
    
        yearTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        Year.selectedYear = newSelectedYear
        yearTextField.text = String(newSelectedYear)
    }
    
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
 
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Year.currentYear()-Year.minimumYear
    }
 
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(Year.yearsArray[row])
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newSelectedYear = Year.yearsArray[row]
    }
}
