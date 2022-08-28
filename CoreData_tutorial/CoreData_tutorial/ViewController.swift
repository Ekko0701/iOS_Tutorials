//
//  ViewController.swift
//  CoreData_tutorial
//
//  Created by Ekko on 2022/08/26.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var itemArray = [Item]()
    
    //  1.  PersistantContainer에서 NSManagedObjectContext를 가져온다.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveData(title: "안녕하세요 에코입니다 :)")
        loadItem()
        print("--------------------")
        updateItem(item: itemArray[0], newTitle: "잘가세요 에코입니다 :(")
        loadItem()
    }
    
    func saveData(title: String) {
//        //  2. Entity 가져오기.
//        let entity = NSEntityDescription.entity(forEntityName: "Item", in: context)
//
//        //  3. Object(item) 설정
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
        do {
            itemArray = try context.fetch(Item.fetchRequest())
            for i in 0..<itemArray.count {
                print(itemArray[i].title!)
            }
        } catch {
            print("Load Error : \(error)")
        }
    }
    
    
    func deleteItem(item: Item) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("Delete Error: \(error)")
        }
    }
    
    func deleteAllItems() {
        let request: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(delete)
        } catch {
            print("Delete All error : \(error)")
        }
    }
    
    func updateItem(item: Item, newTitle: String) {
        item.title = newTitle
        
        do {
            try context.save()
        } catch {
            print("Save Error : \(error)")
        }
    }
}

