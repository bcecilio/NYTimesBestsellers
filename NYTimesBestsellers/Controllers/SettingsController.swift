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
    
    
    let settingsView = SettingsView()

    
    private var listTypes = [ListType]() {
        didSet {
            DispatchQueue.main.async {
                self.settingsView.picker.reloadAllComponents()
            }
        }
    }
    
    
    private let dataPersistence: DataPersistence<Book>
    
    init(_ dataPersistence: DataPersistence<Book>, listType: [ListType]) {
        self.dataPersistence = dataPersistence
        self.listTypes  = listType
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
        loadData()
    }
    
    
    private func loadData() {
        
           let endpoint = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(NYTKey.key)"
           
           GenericCoderAPI.manager.getJSON(objectType: ListTypeWrapper.self, with: endpoint) { result in
               switch result {
               case .failure(let error):
                   print(error)
                   break
               case .success(let wrapper):
                   DispatchQueue.main.async {
                       self.listTypes = wrapper.results
                   }
               }
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
        return listTypes[row].listName
    }
}
