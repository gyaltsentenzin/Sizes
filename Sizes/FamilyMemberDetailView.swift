import SwiftUI

struct FamilyMemberDetailView: View {
    @State private var showEditMemberForm: Bool = false
    let member: FamilyMember
    var onSave: (FamilyMember) -> Void
    var onDelete: () -> Void
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            if let image = member.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }
            
            Text(member.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Shoe Size:").fontWeight(.semibold)
                    Spacer()
                    Text(member.shoeSize)
                }
                HStack {
                    Text("Waist:").fontWeight(.semibold)
                    Spacer()
                    Text(member.waist)
                }
                HStack {
                    Text("Chest:").fontWeight(.semibold)
                    Spacer()
                    Text(member.chest)
                }
                HStack {
                    Text("Inseam:").fontWeight(.semibold)
                    Spacer()
                    Text(member.inseam)
                }
                HStack {
                    Text("Height:").fontWeight(.semibold)
                    Spacer()
                    Text(member.height)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 5)
            
            HStack {
                Button(action: {
                    showEditMemberForm = true
                }) {
                    Text("Edit")
                        .font(.title2)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding()

                Button(action: {
                    onDelete()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Delete")
                        .font(.title2)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
        .sheet(isPresented: $showEditMemberForm) {
            EditFamilyMemberView(member: member, onSave: onSave)
        }
    }
}

struct FamilyMemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleMember = FamilyMember(
            name: "Example",
            imageData: UIImage(systemName: "person")?.jpegData(compressionQuality: 0.8),
            shoeSize: "10",
            waist: "32",
            chest: "40",
            inseam: "32",
            height: "5'10\""
        )
        FamilyMemberDetailView(member: exampleMember, onSave: { _ in }, onDelete: {})
    }
}

