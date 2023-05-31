//
//  ViewController.swift
//  13_03_2023_SQLiteDemo
//
//  Created by Vishal Jagtap on 29/05/23.
//

import UIKit
import SQLite3

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dbHelper = DBHelper()
        dbHelper.insertEmployeeRecord(empId: 10, empName: "Susmita")
        dbHelper.insertEmployeeRecord(empId: 11, empName: "Priyanka")
        dbHelper.insertEmployeeRecord(empId: 12, empName: "Vaishnavi")
        dbHelper.insertEmployeeRecord(empId: 13, empName: "Rohan")
        dbHelper.insertEmployeeRecord(empId: 14, empName: "Tejas")
        dbHelper.deleteEmployeeRecord(empId: 10)
    }
}
