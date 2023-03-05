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
    @State var grouptUpdate: CDGroup = CDGroup()
    @Binding var groups: [CDGroup]
    
    var body: some View {
        VStack {
            if new {
                NewGroup(group: $groups, coreDM: coreDM)
                    .navigationTitle("Nuevo Grupo")
            }
            if groupSelected {
                GroupView(group: $grouptUpdate, groups: $groups, groupSelected: $groupSelected, coreDM: coreDM)
                    .navigationTitle("\(grouptUpdate.name!)")
            }
            TitleList(title: "Nombre")
                .padding(.top, 30)
                .padding(.bottom, -7)
                .padding(.horizontal, 30)
            List {
                ForEach(groups, id: \.self) { groupExtra in
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
    
    func openUpdateProductView(group: CDGroup) {
        withAnimation {
            grouptUpdate = group
            groupSelected = groupSelected ? false : true
            new = false
        }
    }
    
    func moveFromList(indexSet: IndexSet, int: Int) {
        groups.move(fromOffsets: indexSet, toOffset: int)
        coreDM.update()
    }
    
    func deleteFromList(indexSet: IndexSet) {
        indexSet.forEach { index in
            coreDM.deleteGroup(CDgroup: groups[index])
            getList()
        }
    }
    func getList() {
        groups = coreDM.allGroups()
    }
}
