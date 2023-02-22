//
//  AllGroups.swift
//  Fairway
//
//  Created by Felipe Arias on 07/12/22.
//

import SwiftUI

struct AllGroups: View {
    private let coreDM = CoreDataManager()
    @State var new = false
    @State var name = ""
    @State var groupSelected = false
    @State var grouptUpdate: GroupExtra = GroupExtra()
    @Binding var groupExtras: [GroupExtra]
    
    var body: some View {
        VStack {
            if new {
                NewGroup(groupExtra: $groupExtras, coreDM: coreDM)
                    .navigationTitle("Nuevo Grupo")
            }
            if groupSelected {
                GroupView(groupExtra: $grouptUpdate, groupExtras: $groupExtras, groupSelected: $groupSelected, coreDM: coreDM)
                    .navigationTitle("\(grouptUpdate.name!)")
            }
            TitleList(title: "Nombre")
                .padding(.top, 30)
                .padding(.bottom, -7)
                .padding(.horizontal, 30)
            List {
                ForEach(groupExtras, id: \.self) { groupExtra in
                    Button(action: {
                        openUpdateProductView(group: groupExtra)
                    }, label: {
                        HStack{
                            text(text: groupExtra.name ?? "Error")
                        }
                    })
                }
                .onDelete(perform: deleteFromList)
                .onMove(perform: moveFromList)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: newButtonAction,label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
        }.onAppear(perform: getList).background(Color("background"))
    }
    
    func newButtonAction() {
        withAnimation {
            new = new ? false : true
            groupSelected = false
        }
    }
    
    func openUpdateProductView(group: GroupExtra) {
        withAnimation {
            grouptUpdate = group
            groupSelected = groupSelected ? false : true
            new = false
        }
    }
    
    func moveFromList(indexSet: IndexSet, int: Int) {
        groupExtras.move(fromOffsets: indexSet, toOffset: int)
        coreDM.update()
    }
    
    func deleteFromList(indexSet: IndexSet) {
        indexSet.forEach { index in
            let groupGroup = groupExtras[index]
            coreDM.deleteGroup(groupExtra: groupGroup)
            getList()
        }
    }
    func getList() {
        groupExtras = coreDM.allGroups()
    }
}
