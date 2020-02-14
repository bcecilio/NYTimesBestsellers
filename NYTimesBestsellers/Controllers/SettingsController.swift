//
//  SettingsController.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import DataPersistence

class SettingsController: UIViewController {
    
    private var listTypes = List.categories
    private let dataPersistence: DataPersistence<Book>
    private let settingsView = SettingsView()
    
    init(_ dataPersistence: DataPersistence<Book>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func loadView() {
        view = settingsView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        settingsView.picker.dataSource = self
        settingsView.picker.delegate = self
        //settingsView.picker.selectRow(7, inComponent: 0, animated: true)
        checkForDefaultSettings()
        
    }
    
    
    private func checkForDefaultSettings() {
      
        if let row = UserPreferences.helper.getListing() {
            settingsView.picker.selectRow(row, inComponent: 0, animated: true)
       } else {
            print("Else being called")
        }
        
    }
        
        
}

extension SettingsController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listTypes.count
    }
    
    
}

extension SettingsController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserPreferences.helper.store(listNum: row)
    }
}
