import SwiftUI

struct AddFamilyMemberView: View {
    @State private var name: String = ""
    @State private var selectedImage: UIImage?
    @State private var shoeSize: String = ""
    @State private var waist: String = ""
    @State private var chest: String = ""
    @State private var inseam: String = ""
    @State private var height: String = ""
    @State private var showImagePicker: Bool = false
    
    var onAdd: (FamilyMember) -> Void
    @Environment(\.presentationMode) var presentationMode

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
                    let newMember = FamilyMember(
                        name: name,
                        imageData: imageData,
                        shoeSize: shoeSize,
                        waist: waist,
                        chest: chest,
                        inseam: inseam,
                        height: height
                    )
                    onAdd(newMember)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Member")
                }
            }
            .navigationBarTitle("Add Family Member", displayMode: .inline)
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
    AddFamilyMemberView { _ in }
}
