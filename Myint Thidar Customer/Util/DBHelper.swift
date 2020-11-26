//
//  DBHelper.swift
//  Myint Thidar Customer
//
//  Created by Kaung Khant Shar on 30/07/2020.
//  Copyright © 2020 Nanolabs. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper
{
    
    init()
    {
        db = openDatabase()
        createTable()
        
    }

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    
    func createTable() {
       
        let createTableGold = "CREATE TABLE IF NOT EXISTS goldss(id INTEGER,gold_item_id INTEGER,image TEXT,itemCode TEXT,category_id INTEGER,quantity TEXT,total_price DOUBLE,qty INTEGER,gold_stone_kyat TEXT,gold_stone_pal TEXT,gold_stone_yae TEXT,ayot_kyat TEXT,ayot_pal TEXT,ayot_yae TEXT,stone_kyat TEXT,stone_pal TEXT,stone_yae TEXT,stone_value TEXT,currentSalePrice TEXT,order_type TEXT,realtotal_price DOUBLE);"
        var createTableStatementGold: OpaquePointer? = nil

        let createTableDiamond = "CREATE TABLE IF NOT EXISTS diamond(id INTEGER,diamond_item_id INTEGER,category_id INTEGER,itemCode TEXT,price DOUBLE,total_price DOUBLE,gram DOUBLE,quality TEXT,image TEXT,qty INTEGER,diamond_alone TEXT,diamond_number TEXT,yati TEXT);"
        var createTableStatementDiamond: OpaquePointer? = nil

        let createTablePlatinum = "CREATE TABLE IF NOT EXISTS platinum(id INTEGER,platinum_item_id INTEGER,category_id INTEGER,itemCode TEXT,price DOUBLE,total_price DOUBLE,gram DOUBLE,quality TEXT,image TEXT,qty INTEGER);"
        var createTableStatementPlatinum: OpaquePointer? = nil
        
        let createTablefinaltotal = "CREATE TABLE IF NOT EXISTS finalgolds(totalgold INTEGER);"
        var createTableStatementfinaltotal: OpaquePointer? = nil
        
        
        if sqlite3_prepare_v2(db, createTableGold, -1, &createTableStatementGold, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatementGold) == SQLITE_DONE
            {
                print("gold table created.")
                print(createTableGold)
            } else {
                print("gold table could not be created.")
            }
        } else {
            print("CREATE GOLD TABLE statement could not be prepared.")
        }
        if sqlite3_prepare_v2(db, createTableDiamond, -2, &createTableStatementDiamond, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatementDiamond) == SQLITE_DONE
            {
                print("diamone table created.")
                print(createTableDiamond)
            } else {
                print("diamond table could not be created.")
            }
        } else {
            print("CREATE DIAMOND TABLE statement could not be prepared.")
        }
        if sqlite3_prepare_v2(db, createTablePlatinum, -3, &createTableStatementPlatinum, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatementPlatinum) == SQLITE_DONE
            {
                print("platinum table created.")
                print(createTablePlatinum)
            } else {
                print("platinum table could not be created.")
            }
        } else {
            print("CREATE PLATINUM TABLE statement could not be prepared.")
        }
        if sqlite3_prepare_v2(db, createTablefinaltotal, -4, &createTableStatementfinaltotal, nil) == SQLITE_OK
               {
                   if sqlite3_step(createTableStatementfinaltotal) == SQLITE_DONE
                   {
                       print("final table created.")
                       print(createTablefinaltotal)
                   } else {
                       print("final table could not be created.")
                   }
               } else {
                   print("CREATE final TABLE statement could not be prepared.")
               }
    
        
        sqlite3_finalize(createTableStatementGold)
        sqlite3_finalize(createTableStatementDiamond)
        sqlite3_finalize(createTableStatementPlatinum)
        sqlite3_finalize(createTableStatementfinaltotal)
    }
    
   
    func insertGold(id:Int, gold_item_id:Int, image:String, itemCode:String, category_id:Int, quantity:String, total_price : Double, qty : Int, gold_stone_kyat : String, gold_stone_pal : String, gold_stone_yae : String, ayot_kyat : String, ayot_pal : String, ayot_yae : String, stone_kyat : String, stone_pal : String, stone_yae : String, stone_value : String, currentSalePrice : String, order_type : String, realtotal_price : Double)
    {
        let baskets = read()
        for p in baskets
        {
            if p.id == id
            {
                return
            }
        }
        let insertStatementStringGold = "INSERT INTO goldss (id, gold_item_id, image, itemCode, category_id, quantity, total_price, qty, gold_stone_kyat, gold_stone_pal, gold_stone_yae, ayot_kyat, ayot_pal, ayot_yae, stone_kyat, stone_pal, stone_yae, stone_value, currentSalePrice, order_type, realtotal_price) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatementGold: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementStringGold, -1, &insertStatementGold, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatementGold, 1, Int32(gold_item_id))
            sqlite3_bind_text(insertStatementGold, 2, (image as NSString).utf8String, -1, nil)
             sqlite3_bind_text(insertStatementGold, 3, (itemCode as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatementGold, 4, Int32(category_id))
             sqlite3_bind_text(insertStatementGold, 5, (quantity as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatementGold, 6, Double(total_price))
            sqlite3_bind_int(insertStatementGold, 7, Int32(qty))
            sqlite3_bind_text(insertStatementGold, 8, (gold_stone_kyat as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 9, (gold_stone_pal as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 10, (gold_stone_yae as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 11, (ayot_kyat as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 12, (ayot_pal as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 13, (ayot_yae as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 14, (stone_kyat as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 15, (stone_pal as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 16, (stone_yae as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 17, (stone_value as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 18, (currentSalePrice as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatementGold, 19, (order_type as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatementGold, 20, Double(realtotal_price))

            if sqlite3_step(insertStatementGold) == SQLITE_DONE {
                print("Successfully inserted gold row.")
            } else {
                print("Could not insert gold row.")
            }
        } else {
            print("INSERT gold statement could not be prepared.")
        }
        sqlite3_finalize(insertStatementGold)
    }
    
    func insertDiamond(id:Int, diamond_item_id : Int, category_id : Int, itemCode : String, price : Double, total_price : Double, gram : Double, quality : String, image : String, qty : Int, diamond_alone : String, diamond_number : String, yati : String)
   {
       let baskets = readDiamond()
       for p in baskets
       {
           if p.id == id
           {
               return
           }
       }
       let insertStatementStringDiamond = "INSERT INTO diamond (id, diamond_item_id, category_id, itemCode, price, total_price, gram, quality, image, qty, diamond_alone, diamond_number, yati) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
       var insertStatementDiamond: OpaquePointer? = nil
       if sqlite3_prepare_v2(db, insertStatementStringDiamond, -1, &insertStatementDiamond, nil) == SQLITE_OK {
           sqlite3_bind_int(insertStatementDiamond, 1, Int32(diamond_item_id))
           sqlite3_bind_int(insertStatementDiamond, 2, Int32(category_id))
           sqlite3_bind_text(insertStatementDiamond, 3, (itemCode as NSString).utf8String, -1, nil)
           sqlite3_bind_double(insertStatementDiamond, 4, Double(price))
           sqlite3_bind_double(insertStatementDiamond, 5, Double(total_price))
           sqlite3_bind_double(insertStatementDiamond, 6, Double(gram))
           sqlite3_bind_text(insertStatementDiamond, 7, (quality as NSString).utf8String, -1, nil)
           sqlite3_bind_text(insertStatementDiamond, 8, (image as NSString).utf8String, -1, nil)
           sqlite3_bind_int(insertStatementDiamond, 9, Int32(qty))
           sqlite3_bind_text(insertStatementDiamond, 10, (diamond_alone as NSString).utf8String, -1, nil)
           sqlite3_bind_text(insertStatementDiamond, 11, (diamond_number as NSString).utf8String, -1, nil)
           sqlite3_bind_text(insertStatementDiamond, 12, (yati as NSString).utf8String, -1, nil)
        
           

           if sqlite3_step(insertStatementDiamond) == SQLITE_DONE {
               print("Successfully inserted diamond row.")
           } else {
               print("Could not insert diamond row.")
           }
       } else {
           print("INSERT diamond statement could not be prepared.")
       }
       sqlite3_finalize(insertStatementDiamond)
   }
    
    func insertPlatinum(id:Int, platinum_item_id : Int, category_id : Int, itemCode : String, price : Double, total_price : Double, gram : Double, quality : String, image : String, qty : Int)
      {
          let baskets = readPlatinum()
          for p in baskets
          {
              if p.id == id
              {
                  return
              }
          }
          let insertStatementStringPlatinum = "INSERT INTO platinum (id, platinum_item_id, category_id, itemCode, price, total_price, gram, quality, image, qty) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
          var insertStatementPlatinum: OpaquePointer? = nil
          if sqlite3_prepare_v2(db, insertStatementStringPlatinum, -1, &insertStatementPlatinum, nil) == SQLITE_OK {
              sqlite3_bind_int(insertStatementPlatinum, 1, Int32(platinum_item_id))
              sqlite3_bind_int(insertStatementPlatinum, 2, Int32(category_id))
              sqlite3_bind_text(insertStatementPlatinum, 3, (itemCode as NSString).utf8String, -1, nil)
              sqlite3_bind_double(insertStatementPlatinum, 4, Double(price))
              sqlite3_bind_double(insertStatementPlatinum, 5, Double(total_price))
              sqlite3_bind_double(insertStatementPlatinum, 6, Double(gram))
              sqlite3_bind_text(insertStatementPlatinum, 7, (quality as NSString).utf8String, -1, nil)
              sqlite3_bind_text(insertStatementPlatinum, 8, (image as NSString).utf8String, -1, nil)
              sqlite3_bind_int(insertStatementPlatinum, 9, Int32(qty))
           
              

              if sqlite3_step(insertStatementPlatinum) == SQLITE_DONE {
                  print("Successfully inserted platinum row.")
              } else {
                  print("Could not insert platinum row.")
              }
          } else {
              print("INSERT platinum statement could not be prepared.")
          }
          sqlite3_finalize(insertStatementPlatinum)
      }
    
    func insertfinal(goldfinal:Int)
         {
           
            
             let insertStatementStringPlatinum = "INSERT INTO finalgolds (totalgold) VALUES (?);"
             var insertStatementPlatinum: OpaquePointer? = nil
             if sqlite3_prepare_v2(db, insertStatementStringPlatinum, -1, &insertStatementPlatinum, nil) == SQLITE_OK {
                 
                 sqlite3_bind_int(insertStatementPlatinum, 1, Int32(goldfinal))
                 
              if sqlite3_step(insertStatementPlatinum) == SQLITE_DONE {
                     print("Successfully inserted final row.")
                 } else {
                     print("Could not insert final row.")
                 }
             } else {
                 print("INSERT final statement could not be prepared.")
             }
             sqlite3_finalize(insertStatementPlatinum)
         }
    
    
    func read() -> [AddtobasketGold] {
        let queryStatementStringGold = "SELECT * FROM goldss;"
        var queryStatementGold: OpaquePointer? = nil
        var psns : [AddtobasketGold] = []
        if sqlite3_prepare_v2(db, queryStatementStringGold, -1, &queryStatementGold, nil) == SQLITE_OK {
            while sqlite3_step(queryStatementGold) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatementGold, 0)
                let gold_item_id = sqlite3_column_int(queryStatementGold, 1)
                let image = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 2)))
                let itemCode = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 3)))
                let category_id = sqlite3_column_int(queryStatementGold, 4)
                let quantity = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 5)))
                let total_price = sqlite3_column_double(queryStatementGold, 6)
                let qty = sqlite3_column_int(queryStatementGold, 7)
                let gold_stone_kyat = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 8)))
                let gold_stone_pal = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 9)))
                let gold_stone_yae = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 10)))
                let ayot_kyat = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 11)))
                let ayot_pal = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 12)))
                let ayot_yae = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 13)))
                let stone_kyat = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 14)))
                let stone_pal = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 15)))
                let stone_yae = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 16)))
                let stone_value = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 17)))
                let currentSalePrice = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 18)))
                let order_type = String(describing: String(cString: sqlite3_column_text(queryStatementGold, 19)))
                let realtotal_price = sqlite3_column_double(queryStatementGold, 20)
              
                psns.append(AddtobasketGold(id: Int(id), gold_item_id: Int(gold_item_id), image: image, itemCode: itemCode, category_id: Int(category_id), quantity: quantity, total_price: total_price, qty: Int(qty), gold_stone_kyat: gold_stone_kyat, gold_stone_pal: gold_stone_pal, gold_stone_yae: gold_stone_yae, ayot_kyat: ayot_kyat, ayot_pal: ayot_pal, ayot_yae: ayot_yae, stone_kyat: stone_kyat, stone_pal: stone_pal, stone_yae: stone_yae, stone_value: stone_value, currentSalePrice: currentSalePrice, order_type: order_type, realtotal_price: realtotal_price))
                
                print("Gold Query Result:")
                print("\(id) | \(gold_item_id) | \(image) | \(itemCode) | \(category_id) | \(qty) | \(total_price)")
                print("realtotalprice\(realtotal_price) | total_price\(total_price)")
            }
        } else {
            print("SELECT gold statement could not be prepared")
        }
        sqlite3_finalize(queryStatementGold)
        return psns
    }
    
     func readDiamond() -> [AddtobasketDiamond] {
            let queryStatementStringDiamond = "SELECT * FROM diamond;"
            var queryStatementDiamond: OpaquePointer? = nil
            var psns : [AddtobasketDiamond] = []
            if sqlite3_prepare_v2(db, queryStatementStringDiamond, -1, &queryStatementDiamond, nil) == SQLITE_OK {
                while sqlite3_step(queryStatementDiamond) == SQLITE_ROW {
                    let id = sqlite3_column_int(queryStatementDiamond, 0)
                    let diamond_item_id = sqlite3_column_int(queryStatementDiamond, 1)
                    let category_id = sqlite3_column_int(queryStatementDiamond, 2)
                    let itemCode = String(describing: String(cString: sqlite3_column_text(queryStatementDiamond, 3)))
                    let price = sqlite3_column_double(queryStatementDiamond, 4)
                    let total_price = sqlite3_column_double(queryStatementDiamond, 5)
                    let gram = sqlite3_column_double(queryStatementDiamond, 6)
                    let quality = String(describing: String(cString: sqlite3_column_text(queryStatementDiamond, 7)))
                    let image = String(describing: String(cString: sqlite3_column_text(queryStatementDiamond, 8)))
                    let qty = sqlite3_column_int(queryStatementDiamond, 9)
                    let diamond_alone = String(describing: String(cString: sqlite3_column_text(queryStatementDiamond, 10)))
                    let diamond_number = String(describing: String(cString: sqlite3_column_text(queryStatementDiamond, 11)))
                    let yati = String(describing: String(cString: sqlite3_column_text(queryStatementDiamond, 12)))
                    psns.append(AddtobasketDiamond(id: Int(id), diamond_item_id: Int(diamond_item_id), category_id: Int(category_id), itemCode: itemCode, price: price, total_price: total_price, gram: gram, quality: quality, image: image, qty: Int(qty), diamond_alone: diamond_alone, diamond_number: diamond_number, yati: yati))
 
                   
//                    print("Diamond Query Result:")
//                    print("\(id) | \(diamond_item_id) | \(image) | \(itemCode) | \(category_id) | \(qty) | \(total_price)")
                }
            } else {
                print("SELECT diamond statement could not be prepared")
            }
            sqlite3_finalize(queryStatementDiamond)
            return psns
        }
    
    func readPlatinum() -> [AddtobasketPlatinum] {
               let queryStatementStringPlatinum = "SELECT * FROM platinum;"
               var queryStatementPlatinum: OpaquePointer? = nil
               var psns : [AddtobasketPlatinum] = []
               if sqlite3_prepare_v2(db, queryStatementStringPlatinum, -1, &queryStatementPlatinum, nil) == SQLITE_OK {
                   while sqlite3_step(queryStatementPlatinum) == SQLITE_ROW {
                       let id = sqlite3_column_int(queryStatementPlatinum, 0)
                       let platinum_item_id = sqlite3_column_int(queryStatementPlatinum, 1)
                       let category_id = sqlite3_column_int(queryStatementPlatinum, 2)
                       let itemCode = String(describing: String(cString: sqlite3_column_text(queryStatementPlatinum, 3)))
                       let price = sqlite3_column_double(queryStatementPlatinum, 4)
                       let total_price = sqlite3_column_double(queryStatementPlatinum, 5)
                       let gram = sqlite3_column_double(queryStatementPlatinum, 6)
                       let quality = String(describing: String(cString: sqlite3_column_text(queryStatementPlatinum, 7)))
                       let image = String(describing: String(cString: sqlite3_column_text(queryStatementPlatinum, 8)))
                       let qty = sqlite3_column_int(queryStatementPlatinum, 9)
                      
                      
                    psns.append(AddtobasketPlatinum(id: Int(id), platinum_item_id: Int(platinum_item_id), category_id: Int(category_id), itemCode: itemCode, price: price, total_price: total_price, gram: gram, quality: quality, image: image, qty: Int(qty)))
    
                      
                      // print("Query Result:")
                       //print("\(id) | \(platinum_item_id) | \(image) | \(itemCode) | \(category_id) | \(qty) | \(total_price)")
                   }
               } else {
                   print("SELECT platinum statement could not be prepared")
               }
               sqlite3_finalize(queryStatementPlatinum)
               return psns
           }

    func dropGoldRow() {
        let deleteStatmentString = "DELETE FROM goldss;"
         var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatmentString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
        
    }
    func dropDiamondRow() {
        let deleteStatmentString = "DELETE FROM diamond;"
         var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatmentString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
        
    }
    func dropPlatinumRow() {
        let deleteStatmentString = "DELETE FROM platinum;"
         var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatmentString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
        
    }
//
//
//
//
    func sumGold() -> (Int) {

        
           var result : Int = 0
           let querystatement = "SELECT SUM(total_price) FROM goldss;"
            var queryStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, querystatement, -1, &queryStatement, nil) == SQLITE_OK {
                 while sqlite3_step(queryStatement) == SQLITE_ROW {
                   result = Int(sqlite3_column_int(queryStatement, 0))

               }
           } else {
               print("error")
           }
           sqlite3_finalize(queryStatement)

           return result
       }
    
    func sumDiamond() -> (Int) {

        var result : Int = 0
        let querystatement = "SELECT SUM(total_price) FROM diamond;"
         var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, querystatement, -1, &queryStatement, nil) == SQLITE_OK {
              while sqlite3_step(queryStatement) == SQLITE_ROW {
                result = Int(sqlite3_column_int(queryStatement, 0))

            }
        } else {
            print("error")
        }
        sqlite3_finalize(queryStatement)

        return result
    }
    
    func sumTotalDiamond() -> (Int) {

        var result : Int = 0
        let querystatement = "SELECT SUM(price*qty) FROM diamond;"
         var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, querystatement, -1, &queryStatement, nil) == SQLITE_OK {
              while sqlite3_step(queryStatement) == SQLITE_ROW {
                result = Int(sqlite3_column_int(queryStatement, 0))

            }
        } else {
            print("error")
        }
        sqlite3_finalize(queryStatement)

        return result
    }
    
    func sumPlatinum() -> (Int) {

        var result : Int = 0
        let querystatement = "SELECT SUM(total_price) FROM platinum;"
         var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, querystatement, -1, &queryStatement, nil) == SQLITE_OK {
              while sqlite3_step(queryStatement) == SQLITE_ROW {
                result = Int(sqlite3_column_int(queryStatement, 0))

            }
        } else {
            print("error")
        }
        sqlite3_finalize(queryStatement)

        return result
    }
    
    func sumTotalPlatinum() -> (Int) {

        var result : Int = 0
        let querystatement = "SELECT SUM(price*qty) FROM platinum;"
         var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, querystatement, -1, &queryStatement, nil) == SQLITE_OK {
              while sqlite3_step(queryStatement) == SQLITE_ROW {
                result = Int(sqlite3_column_int(queryStatement, 0))

            }
        } else {
            print("error")
        }
        sqlite3_finalize(queryStatement)

        return result
    }
//    func sumQuantity(id:Int,quantity:Int)  {
//        let updateStatementString = "UPDATE baskettabless SET quantity = quantity + ? WHERE realproduct_id = ?;"
//         var updateStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
//                    sqlite3_bind_int(updateStatement, 1, Int32(quantity))
//                   sqlite3_bind_int(updateStatement, 2, Int32(id))
//                      //sqlite3_bind_int(updateStatement, 1, Int32(id))
//                      if sqlite3_step(updateStatement) == SQLITE_DONE {
//                          print("Successfully updated item row.")
//                      } else {
//                          print("Could not update item row.")
//                      }
//                  }else {
//                      print("UPDATE statement could not be prepared")
//                  }
//                  sqlite3_finalize(updateStatement)
//    }
//
//    //UPDATE Contact SET Name = 'Chris' WHERE Id = 1;
//    func sumByID(id:Int) ->(Int) {
//
//        var result : Int = 0
//            let queryStatementString = "SELECT realproduct_id FROM baskettabless WHERE realproduct_id = ?;"
//            var queryStatement: OpaquePointer? = nil
//            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//                  sqlite3_bind_int(queryStatement, 1, Int32(id))
//                 while sqlite3_step(queryStatement) == SQLITE_ROW {
//                   result = Int(sqlite3_column_int(queryStatement, 0))
//              print("result\(result)")
//
//
//           }
//
//            } else {
//                print("error")
//        }
//        sqlite3_finalize(queryStatement)
//
//        return result
//
//    }
//
//    func dropRow() {
//        let deleteStatmentString = "DELETE FROM baskettabless;"
//         var deleteStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, deleteStatmentString, -1, &deleteStatement, nil) == SQLITE_OK {
//            if sqlite3_step(deleteStatement) == SQLITE_DONE {
//                print("Successfully deleted row.")
//            } else {
//                print("Could not delete row.")
//            }
//        } else {
//            print("DELETE statement could not be prepared")
//        }
//        sqlite3_finalize(deleteStatement)
//
//    }
//
    func updateBygoldID(gold_item_id:Int,qty:Int) {

           let updateStatementStirng = "UPDATE goldss SET qty = ? WHERE gold_item_id = ?;"
           var updateStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, updateStatementStirng, -1, &updateStatement, nil) == SQLITE_OK {
             sqlite3_bind_int(updateStatement, 1, Int32(qty))
            sqlite3_bind_int(updateStatement, 2, Int32(gold_item_id))
            
               //sqlite3_bind_int(updateStatement, 1, Int32(id))
               if sqlite3_step(updateStatement) == SQLITE_DONE {
                   print("Successfully updated row.")
               } else {
                   print("Could not update row.")
               }
           } else {
               print("UPDATE statement could not be prepared")
           }
           sqlite3_finalize(updateStatement)
       }
    
    func updateBygoldtotalprice(gold_item_id:Int,totalprice:Int) {

              let updateStatementStirng = "UPDATE goldss SET total_price = ? WHERE gold_item_id = ?;"
              var updateStatement: OpaquePointer? = nil
              if sqlite3_prepare_v2(db, updateStatementStirng, -1, &updateStatement, nil) == SQLITE_OK {
                sqlite3_bind_int(updateStatement, 1, Int32(totalprice))
               sqlite3_bind_int(updateStatement, 2, Int32(gold_item_id))
               
                  //sqlite3_bind_int(updateStatement, 1, Int32(id))
                  if sqlite3_step(updateStatement) == SQLITE_DONE {
                      print("Successfully updated totalprice row.")
                  } else {
                      print("Could not update totalprice row.")
                  }
              } else {
                  print("UPDATE statement could not be prepared")
              }
              sqlite3_finalize(updateStatement)
          }
    
    func updateBydiamondID(diamond_item_id:Int,qty:Int) {

        let updateStatementStirng = "UPDATE diamond SET qty = ? WHERE diamond_item_id = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementStirng, -1, &updateStatement, nil) == SQLITE_OK {
          sqlite3_bind_int(updateStatement, 1, Int32(qty))
         sqlite3_bind_int(updateStatement, 2, Int32(diamond_item_id))
            //sqlite3_bind_int(updateStatement, 1, Int32(id))
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
    
    func updateByplatinumID(platinum_item_id:Int,qty:Int) {

        let updateStatementStirng = "UPDATE platinum SET qty = ? WHERE platinum_item_id = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementStirng, -1, &updateStatement, nil) == SQLITE_OK {
          sqlite3_bind_int(updateStatement, 1, Int32(qty))
         sqlite3_bind_int(updateStatement, 2, Int32(platinum_item_id))
            //sqlite3_bind_int(updateStatement, 1, Int32(id))
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
//
    func deleteBygolditemid(golditemid:Int) {
        let deleteStatementStirng = "DELETE FROM goldss WHERE gold_item_id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(golditemid))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func deleteBydiamonditemid(diamonditemid:Int) {
        let deleteStatementStirng = "DELETE FROM diamond WHERE diamond_item_id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(diamonditemid))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    func deleteByplatinumitemid(platinumitemid:Int) {
          let deleteStatementStirng = "DELETE FROM platinum WHERE platinum_item_id = ?;"
          var deleteStatement: OpaquePointer? = nil
          if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
              sqlite3_bind_int(deleteStatement, 1, Int32(platinumitemid))
              if sqlite3_step(deleteStatement) == SQLITE_DONE {
                  print("Successfully deleted row.")
              } else {
                  print("Could not delete row.")
              }
          } else {
              print("DELETE statement could not be prepared")
          }
          sqlite3_finalize(deleteStatement)
      }
    func sumbygoldid(id:Int) ->(Int) {
        
        var result : Int = 0
            let queryStatementString = "SELECT gold_item_id FROM goldss WHERE gold_item_id = ?;"
            var queryStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                  sqlite3_bind_int(queryStatement, 1, Int32(id))
                 while sqlite3_step(queryStatement) == SQLITE_ROW {
                   result = Int(sqlite3_column_int(queryStatement, 0))
              print("result\(result)")
                    
                  
           }

            } else {
                print("error")
        }
        sqlite3_finalize(queryStatement)
      
        return result
    
    }
    
    func sumbydiamondid(id:Int) ->(Int) {
        
        var result : Int = 0
            let queryStatementString = "SELECT diamond_item_id FROM diamond WHERE diamond_item_id = ?;"
            var queryStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                  sqlite3_bind_int(queryStatement, 1, Int32(id))
                 while sqlite3_step(queryStatement) == SQLITE_ROW {
                   result = Int(sqlite3_column_int(queryStatement, 0))
              print("result\(result)")
                    
                  
           }

            } else {
                print("error")
        }
        sqlite3_finalize(queryStatement)
      
        return result
    
    }
    
    func sumbyplatinumid(id:Int) ->(Int) {
        
        var result : Int = 0
            let queryStatementString = "SELECT platinum_item_id FROM platinum WHERE platinum_item_id = ?;"
            var queryStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                  sqlite3_bind_int(queryStatement, 1, Int32(id))
                 while sqlite3_step(queryStatement) == SQLITE_ROW {
                   result = Int(sqlite3_column_int(queryStatement, 0))
              print("result\(result)")
                    
                  
           }

            } else {
                print("error")
        }
        sqlite3_finalize(queryStatement)
      
        return result
    
    }
    
}

