//
//  ViewController.swift
//  13_03_2023_SQLiteDemo
//
//  Created by Vishal Jagtap on 29/05/23.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    var e : [Employee] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let dbHelper = DBHelper()
        print("-----Add Employee Records-----")
        dbHelper.insertEmployeeRecord(empId: 10, empName: "Susmita")
        dbHelper.insertEmployeeRecord(empId: 11, empName: "Priyanka")
        dbHelper.insertEmployeeRecord(empId: 12, empName: "Vaishnavi")
        dbHelper.insertEmployeeRecord(empId: 13, empName: "Rohan")
        dbHelper.insertEmployeeRecord(empId: 14, empName: "Tejas")
        dbHelper.insertEmployeeRecord(empId: 15, empName: "Yuvaraj")
        print("-----Retrive all Employee Records-----")
        //e = dbHelper.retriveAllEmployees()
//        for eachEmp in dbHelper.retriveAllEmployees(){
//            print("Emp Record -- \(eachEmp.empId) -- \(eachEmp.empName)")
//        }
        print("Delete Employee record")
        dbHelper.deleteEmployeeRecord(empId: 10)
    }
}
