import SwiftUI

struct EditFamilyMemberView: View {
    @State private var name: String
    @State private var selectedImage: UIImage?
    @State private var shoeSize: String
    @State private var waist: String
    @State private var chest: String
    @State private var inseam: String
    @State private var height: String
    @State private var showImagePicker: Bool = false
    
    var member: FamilyMember
    var onSave: (FamilyMember) -> Void
    @Environment(\.presentationMode) var presentationMode

    init(member: FamilyMember, onSave: @escaping (FamilyMember) -> Void) {
        self.member = member
        self.onSave = onSave
        _name = State(initialValue: member.name)
        _shoeSize = State(initialValue: member.shoeSize)
        _waist = State(initialValue: member.waist)
        _chest = State(initialValue: member.chest)
        _inseam = State(initialValue: member.inseam)
        _height = State(initialValue: member.height)
        _selectedImage = State(initialValue: member.image)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Family Member Details")) {
                    TextField("Name", text: $name)
                    
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Text("Select Image")
                    }
                    
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                    }
                    
                    TextField("Shoe Size", text: $shoeSize)
                    TextField("Waist", text: $waist)
                    TextField("Chest", text: $chest)
                    TextField("Inseam", text: $inseam)
                    TextField("Height", text: $height)
                }
                
                Button(action: {
                    let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
                    let updatedMember = FamilyMember(
                        id: member.id, // Keep the same ID
                        name: name,
                        imageData: imageData,
                        shoeSize: shoeSize,
                        waist: waist,
                        chest: chest,
                        inseam: inseam,
                        height: height
                    )
                    onSave(updatedMember)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            }
            .navigationBarTitle("Edit Family Member", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
}

#Preview {
    EditFamilyMemberView(member: FamilyMember(name: "Example", imageData: nil, shoeSize: "10", waist: "32", chest: "40", inseam: "32", height: "5'10\"")) { _ in }
}

