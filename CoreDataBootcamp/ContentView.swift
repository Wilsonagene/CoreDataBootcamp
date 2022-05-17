//
//  ContentView.swift
//  CoreDataBootcamp
//
//  Created by wilson agene on 5/17/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: FruitsEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitsEntity.name, ascending: true)])
    var fruits: FetchedResults<FruitsEntity>
    
    @State var  textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20) {
                TextField("Add Fruit Here......", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding()
                
                Button {
                    addItem()
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                List {
                    ForEach(fruits) { fruit in
                        Text(fruit.name ?? "")
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
            .navigationTitle("Fruits")
            Text("Select an item")
        }
    }
 
    private func addItem() {
        withAnimation {
            let newFruit = FruitsEntity(context: viewContext)
            newFruit.name = textFieldText
            saveitems()
            textFieldText = ""
        }
    }

    private func updateItem() {
        withAnimation {
            
        }
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else {return}
            let fruitEntity = fruits[index]
            viewContext.delete(fruitEntity)
            saveitems()
        }
    }
    
    private func saveitems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
