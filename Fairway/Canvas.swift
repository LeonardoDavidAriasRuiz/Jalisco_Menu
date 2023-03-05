//
//  canvas.swift
//  Fairway
//
//  Created by Felipe Arias on 08/12/22.
//

import SwiftUI

struct Canvas: View {
    var body: some View {
        Text("")
    }
}

extension View {
    func whiteRecatangleRounded() -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.bottom,15)
            .background(Color("backgroudOptionsProducts&Modifires"))
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .padding(.trailing, 25)
    }
    
    func titleNewItem() -> some View {
        self
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
            .padding(.top, 40)
            .padding(.trailing, 25)
    }
    func titleAllItem() -> some View {
        self
            .padding(.horizontal, 30)
            .padding(.bottom, -5)
            .padding(.top, 40)
            .padding(.trailing, 25)
    }
}

struct SelectGroupOption: View {
    let product: Product
    let group: GroupExtra
    @Binding var selected: Bool
    var body: some View {
        Text(group.name ?? "Error")
            .frame(maxWidth: .infinity, minHeight: 50)
            .foregroundColor(compareGroupProdct() ? Color.white : Color.blue)
            .background(compareGroupProdct() ? Color.blue : Color.white)
            .cornerRadius(10)
    }
    
    func compareGroupProdct() -> Bool {
        let groupsProduct = CoreDataManager().allGroupsProduct()
        for union in groupsProduct {
            if union.idProduct == product.id && union.idGroup == group.id {
                return true
            }
        }
        return false
    }
}

struct MenuUpdate: View {
    @Binding var condition1: Bool
    @Binding var condition2: Bool
    
    var body: some View {
        Button(action: updateData,label: {
            Label("Actualizar datos", systemImage: "icloud.and.arrow.down")
        })
    }
    
    func updateData() {
        withAnimation {
            condition1 = true
            condition1 = false
            condition2 = true
            condition2 = false
        }
    }
}

struct MenuButton: View {
    
    enum itemType {
        case category
        case product
        case group
        case extra
        case order
    }
    
    enum button {
        case AddNew
        case EditItem
    }
    
    let action: () -> Void
    @Binding var condition: Bool
    let type: itemType
    let button: button
    
    var body: some View {
        Button(action: action,label: {
            Label(getText(), systemImage: getIcon())
        })
    }
    
    func getIcon() -> String {
        switch self.button {
        case .AddNew: return condition ? "trash" : "square.and.pencil"
        case .EditItem: return condition ? "pencil.slash" : "pencil"
        }
    }
    
    func getText() -> String {
        switch self.button {
        case .AddNew: return condition ? "No crear \(getType())" : "Agregar \(getType())"
        case .EditItem: return condition ? "No editar" : "Editar \(getType())"
        }
    }
    
    func getType() -> String {
        switch type {
        case .category: return "categoría"
        case .product: return "producto"
        case .group: return "grupo"
        case .extra: return "extra"
        case .order: return "orden"
        }
    }
}

struct TextFieldText: View {
    @Binding var text: String
    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(maxWidth: .infinity)
            .submitLabel(SubmitLabel.done)
    }
}

struct TextFieldNumber: View {
    @Binding var text: String
    var body: some View {
        TextField("", text: $text)
            .keyboardType(.decimalPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(maxWidth: .infinity)
            .submitLabel(SubmitLabel.done)
    }
}

struct TitleListCenter: View {
    let title: String
    var body: some View {
        Text(title).frame(maxWidth: .infinity, alignment: .center).bold()
    }
}

struct TitleList: View {
    let title: String
    var body: some View {
        
        Text(title).frame(maxWidth: .infinity, alignment: .leading).bold()
    }
}

struct ChooseColor: View {
    @Binding var color: Color
    var body: some View {
        ColorPicker("", selection: $color)
            .frame(width: 30)
            .padding(20)
            .frame(maxWidth: .infinity)
    }
}

struct CategoryPicker: View {
    @Binding var categories: [CategoryProduct]
    @Binding var selectedCategory: CategoryProduct
    
    var body: some View {
        Picker("", selection: $selectedCategory) {
            ForEach(categories, id: \.self) { categoryProduct in
                Text(categoryProduct.name ?? "Error")
                    .tag("")
            }
        }.frame(width: 150, height: 30)
    }
}

struct VisibleToggle: View {
    @Binding var visible: Bool
    var body: some View {
        Toggle(isOn: $visible) {
            Text("Imprimir")
                .frame(alignment: .trailing)
        }.frame(maxWidth: 150)
    }
}

struct text: View {
    let text: String
    var body: some View {
        Text(text).frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ItemColor {
    func color(red: Double, green: Double, blue: Double) -> some View {
        return Text("")
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: red, green: green, blue: blue))
            .cornerRadius(10)
    }
    
    func color(color: Color) -> some View {
        return Text("")
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(color)
            .cornerRadius(10)
    }
}

struct SaveButton: View {
    var body: some View {
        Text("Guardar")
            .foregroundColor(.white)
            .font(Font.title)
            .frame(width: 200, height: 30)
            .background(Color.accentColor)
            .cornerRadius(20)
    }
}

struct SeccionTextField: View {
    let title: String
    let empty: String
    let symbol: String
    @Binding var text: String
    var body: some View{
        HStack {
            Image(systemName: symbol)
                .frame(maxWidth: 10)
                .padding(.trailing,8)
            Text(title)
                .frame(maxWidth: 200, alignment: .leading)
            TextField(empty, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity)
        }.frame(width: 600).font(Font.title3)
    }
}

struct Titles {
    var category: some View {
        HStack {
            TitleList(title: "Nombre")
            TitleListCenter(title: "Color")
        }
    }
    var product: some View {
        HStack {
            TitleList(title: "Nombre")
            TitleList(title: "Impresora")
            TitleList(title: "Regular")
            TitleList(title: "Door Dash")
            TitleList(title: "Grubhub")
            TitleListCenter(title: "Color")
        }
    }
    var group: some View {
        HStack {
            TitleList(title: "Nombre")
        }
    }
    var extra: some View {
        HStack {
            TitleList(title: "Nombre")
            TitleList(title: "Impresora")
            TitleList(title: "Regular")
            TitleList(title: "Door Dash")
            TitleList(title: "Grubhub")
        }
    }
}
