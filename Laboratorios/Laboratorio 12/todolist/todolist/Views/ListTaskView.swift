//
//  ListTaskView.swift
//  todolist
//
//  Created by Andrey Leal on 9/10/21.
//

import SwiftUI

struct ListTaskView: View {
    @ObservedObject var coreDataVM = CoreDataViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                List{ ForEach(coreDataVM.tasks , id: \.self){
                        task in
                        NavigationLink(
                            destination: TaskDetailsView(task: task),
                            label: {
                                Label(
                                    task.title ?? "No Name",
                                    systemImage: priorityImages(prioriy: task.priority ?? "")
                                )
                            }
                        )
                        
                    }
                .onDelete(perform: { indexSet in
                    indexSet.forEach{ index in
                        let task = coreDataVM.tasks[index]
                        coreDataVM.deleteTask(task: task)
                        coreDataVM.getAllTask()
                        
                    }
                })
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("TO DO LIST")
            .navigationBarItems(
                trailing: NavigationLink(
                    destination: AddTaskView()){
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                }
            )
        }
        .onAppear(perform: {
            self.coreDataVM.getAllTask()
        })
        
    }
    
    func priorityImages(prioriy:String)->String{
        switch prioriy {
        case "Low":
            return "3.square"
        case "Normal":
            return "2.square"
        default:
            return "1.square"
        }
    }
}

struct ListTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ListTaskView()
    }
}
