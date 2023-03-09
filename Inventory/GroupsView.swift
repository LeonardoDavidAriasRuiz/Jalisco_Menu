//
//  GroupsView.swift
//  Fairway
//
//  Created by Leonardo David Arias Ruiz on 05/03/23.
//

import SwiftUI

struct GroupsView: View {
    @EnvironmentObject private var inventory: Inventory
    @State private var group = ""
    var body: some View {
        VStack {
            
            newProductArea
            productsList
            
        }.background(Color("background"))
    }
    
    var newProductArea: some View {
        VStack {
            Titles().group
            HStack {
                TextFieldText(text: $group)
            }
            Button(action: createGroup, label: {SaveButton()})
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.white)
        .cornerRadius(10)
        .padding(20)
    }
    
    var productsList: some View {
        List{
            ForEach(inventory.groups, id: \.self) { group in
                HStack {
                    Text(group.name ?? "")
                }
            }
            .onDelete(perform: deleteGroup)
        }
    }
    
    func createGroup() {
        CoreDataManager().createGroup(name: group)
        group = ""
        inventory.groups = CoreDataManager().allGroups()
    }
    
    func deleteGroup(indexSet: IndexSet) {
        indexSet.forEach { index in
            CoreDataManager().deleteGroup(CDgroup: inventory.groups[index])
            inventory.groups = CoreDataManager().allGroups()
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}
