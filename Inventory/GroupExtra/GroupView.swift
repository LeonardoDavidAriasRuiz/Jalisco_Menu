//
//  GroupView.swift
//  Fairway
//
//  Created by Felipe Arias on 08/12/22.
//

import SwiftUI

struct GroupView: View {
    @State var name = "-"
    @State var color = Color.green
    @Binding var group: CDGroup
    @Binding var groups: [CDGroup]
    @Binding var groupSelected: Bool
    let coreDM: CoreDataManager
    
    var body: some View {
        VStack {
            SeccionTextField(title: "Nombre", empty: "Nombre del producto", symbol: "character.cursor.ibeam", text: $name)
            Button(action: updateButton , label: {
                SaveButton()}
            )
        }.onAppear(perform: onApper)
    }
    
    func onApper(){
        name = group.name ?? "Error"
    }
    
    func updateButton() {
        withAnimation {
            group.name = name
            coreDM.update()
            groups = coreDM.allGroups()
        }
    }
}
