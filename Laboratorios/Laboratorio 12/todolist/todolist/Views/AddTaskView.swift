//
//  AddTaskView.swift
//  todolist
//
//  Created by Andrey Leal on 9/10/21.
//

import SwiftUI

struct AddTaskView: View {
    //MARK: - VARIABLES
    
    @State var taskTitle: String = ""
    @State var taskText: String = ""
    @State var priority: String = ""
    
    let priorities = ["Low" , "Normal" , "High"]
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var coreDataVM = CoreDataViewModel()
    
    //MARK: - VIEW
    var body: some View {
        //NavigationView{
            VStack{
                Form{
                    Text("Task Title")
                    TextField("I need to do ...", text: $taskTitle)
                    Text("Describe your task")
                    TextEditor(text: $taskText)
                        .frame(minHeight:200.0 , maxHeight:200)
                    Picker("Priority" , selection: $priority){
                        ForEach(priorities , id: \.self){ text in
                            Text(text)
                        }
                    }
                }
                
                Button(action:{
                    Save()
                }){
                    HStack{
                        Image(systemName: "plus.circle.fill")
                        Text("Add")
                    }
                }
                .foregroundColor(Color.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(15.0)
            }
            .toolbar{
                ToolbarItem(placement: .principal){
                    VStack{
                        Text("Add Task").font(.headline)
                    }
                }
            }
        //}
    }
    
    func Save(){
        self.coreDataVM.saveTask(title: taskTitle, description: taskText, priority: priority)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
