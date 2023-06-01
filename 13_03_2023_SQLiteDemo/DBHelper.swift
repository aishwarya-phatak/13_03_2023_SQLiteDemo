//
//  DBHelper.swift
//  13_03_2023_SQLiteDemo
//
//  Created by Vishal Jagtap on 30/05/23.
//

import Foundation
import SQLite3

class DBHelper{
    let dbPath : String = "my_db_iOSBatch.sqlite"
    var db : OpaquePointer?
    
    init() {
       db = openDatabase()
       createTable()
    }
    
    func openDatabase()->OpaquePointer?{
        let fileUrl = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathExtension(dbPath)
        
        print("File Url path : \(fileUrl)")
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("error opening database")
            return nil
        } else {
            print("Db is : \(dbPath)")
            return db
        }
    }
    
    func createTable(){
        let createTableString = "CREATE TABLE IF NOT EXISTS Employee(empId INTEGER PRIMARY KEY, empName TEXT);"
        var createTableStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                              createTableString,
                              -1,
                              &createTableStatement,
                              nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("Employee Table is created successfully")
            } else {
                print("Employee Table could not be created")
            }
        } else {
            print("Create Statement could not be prepared")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertEmployeeRecord(empId : Int, empName : String){
        let e = retriveAllEmployees()
        for eachEmp in e {
            if (empId == eachEmp.empId){
                print("Employee already existing")
            }
        }
        
        let insertQueryString = "INSERT INTO Employee(empId, empName) VALUES(?,?);"
        var insertStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                              insertQueryString,
                              -1,
                              &insertStatement,
                              nil) == SQLITE_OK{
            sqlite3_bind_int(insertStatement, 1, Int32(empId))
            sqlite3_bind_text(insertStatement,
                              2,
                              (empName as NSString).utf8String,
                              -1,
                              nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Row inserted scuccessfully")
            } else {
                print("Row insertion Failed")
            }
        } else {
            print("Insert Query Statement Not Created")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func deleteEmployeeRecord(empId : Int){
        let deleteQueryString = "DELETE FROM Employee WHERE empId = ?;"
        var deleteStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                              deleteQueryString,
                              -1,
                              &deleteStatement,
                              nil) == SQLITE_OK{
            print("The delete statement is executed")
            sqlite3_bind_int(deleteStatement, 1, Int32(empId))
        } else {
            print("The delete statement not prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func retriveAllEmployees()->[Employee]{
        var employees : [Employee] = []
        let retriveEmployessQueryString = "SELECT * FROM Employee;"
        var retriveStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                              retriveEmployessQueryString,
                              -1,
                              &retriveStatement,
                              nil) == SQLITE_OK{
            while sqlite3_step(retriveStatement) == SQLITE_ROW{
              let retrivedEmpId = sqlite3_column_int(retriveStatement, 0)
              let retrivedEmpName = String(describing: String(cString:sqlite3_column_text(retriveStatement, 1)))
                
                employees.append(Employee(empId: Int(retrivedEmpId), empName: retrivedEmpName))
//                print("Emp Details -- \(retrivedEmpId) -- \(retrivedEmpName)")
            }
            for eachEmp in employees{
                print("Emp Id ==\(eachEmp.empId)")
            }
        }else {
            print("Retrive Statment is not prepared")
        }
        sqlite3_finalize(retriveStatement)
        return employees
    }
}
