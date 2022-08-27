//
//  ViewController.swift
//  CoreData_tutorial
//
//  Created by Ekko on 2022/08/26.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        saveData(title: ";;")
        loadItem()
        deleteItem(object: items.last!)
        print("---")
        loadItem()
        //deleteAllItems()
    }
    
    func saveData(title: String) {
        // 1. AppDelegate 내부의 viewContext 가져오기.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 2. Entity 가져오기.
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: context)
        
//        // 3. Object(item) 설정
//        if let entity = entity {
//            let item = NSManagedObject(entity: entity, insertInto: context)
//            item.setValue(title, forKey: "title")
//            item.setValue(false, forKey: "check")
//        }
        
        // 3. Object(item) 설정 다른 방법
        let newItem = Item(context: context)
        newItem.title = title
        newItem.check = false
        
        // 4. NSManagedContext에 저장
        do {
            try context.save()
        } catch {
            print("Save Error : \(error)")
        }
    }
    
    func loadItem() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            items = try context.fetch(Item.fetchRequest())
//            for i in 0..<items.count {
//                print(items[i].title)
//            }
        } catch {
            print("Load Error : \(error)")
        }
    }
    
    func deleteItem(object: Item) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(object)
        do {
            try context.save()
        } catch {
            print("Delete Error: \(error)")
        }
    }
    
    func deleteAllItems() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(delete)
        } catch {
            print("Delete All error : \(error)")
        }
    }
    
    func updateItem(item: Item, newTitle: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        item.title = newTitle
        
        do {
            try context.save()
        } catch {
            print("Save Error : \(error)")
        }
    }
}

