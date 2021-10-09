//
//  CoreDataManager.swift
//  todolist
//
//  Created by Andrey Leal on 9/10/21.
//

import Foundation
import CoreData

class CoreDataManager{
    
    let persistentContainer: NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "TaskDataModel")
        persistentContainer.loadPersistentStores{ ( description , error ) in
            if let error = error {
                print("Unable to load Core Data Store \(error)")
            }
        }
    }
    
    func saveTask(title: String , description: String , priority: String){
        let task = TaskEntity(context: persistentContainer.viewContext)
        task.title = title
        
        task.priority = priority
        task.taskDescription = description
        
        if let result = try? persistentContainer.viewContext.save(){
            print("Success to save task")
        }
        else{
            print("Failed to save task")
        }
    }
    
    func getAllTask()->[TaskEntity]{
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        
        if let result = try? persistentContainer.viewContext.fetch(fetchRequest){
            print("Success to retrieve all task")
            return result
        }
        
        print("Failed to retrieve all task")
        return []
    }
    
    func deleteTask(task: TaskEntity){
        persistentContainer.viewContext.delete(task)
        
        if let result = try? persistentContainer.viewContext.save(){
            print("Success to delete task")
        }
        else{
            persistentContainer.viewContext.rollback()
            print("Failed to delete task")
        }
    }
}
