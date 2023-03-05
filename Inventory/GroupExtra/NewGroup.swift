//
//  NewGroup.swift
//  Fairway
//
//  Created by Felipe Arias on 07/12/22.
//

import SwiftUI

struct NewGroup: View {
    @State var name = "-"
    @State var color = Color.green
    @Binding var group: [CDGroup]
    let coreDM: CoreDataManager
    
    var body: some View {
        VStack {
            SeccionTextField(title: "Nombre", empty: "Nombre del producto", symbol: "character.cursor.ibeam", text: $name)
            Button(action: saveNewGroup, label: {
                SaveButton()}
            )
        }
    }
    
    func saveNewGroup() {
        withAnimation {
            coreDM.createGroup(name: name)
            group = coreDM.allGroups()
        }
    }
}

