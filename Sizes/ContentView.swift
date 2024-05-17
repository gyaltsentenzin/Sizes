import SwiftUI

struct ContentView: View {
    @State private var familyMembers: [FamilyMember] = []
    @State private var selectedMember: FamilyMember?
    @State private var showDetail: Bool = false
    @State private var showAddMemberForm: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                if !showDetail {
                    VStack {
                        Spacer()
                        
                        Text("Family Sizes")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .accessibilityAddTraits(.isHeader)
                            .padding(.bottom, 20)

                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(familyMembers) { member in
                                    if let image = member.image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 150)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                            .shadow(radius: 10)
                                            .onTapGesture {
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    selectedMember = member
                                                    showDetail = true
                                                }
                                            }
                                    }
                                }
                            }
                            .padding()
                        }
                        .transition(.move(edge: .bottom))
                        
                        Spacer()
                    }
                }
                
                if showDetail, let member = selectedMember {
                    VStack {
                        FamilyMemberDetailView(
                            member: member,
                            onSave: { updatedMember in
                                if let index = familyMembers.firstIndex(where: { $0.id == updatedMember.id }) {
                                    familyMembers[index] = updatedMember
                                    saveFamilyMembers()
                                }
                            },
                            onDelete: {
                                if let index = familyMembers.firstIndex(where: { $0.id == member.id }) {
                                    familyMembers.remove(at: index)
                                    saveFamilyMembers()
                                    showDetail = false
                                }
                            }
                        )
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showDetail = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    selectedMember = nil
                                }
                            }
                        }) {
                            Text("Back")
                                .font(.title2)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .transition(.move(edge: .bottom))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddMemberForm = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                }
            }
            .onAppear(perform: loadFamilyMembers)
            .sheet(isPresented: $showAddMemberForm) {
                AddFamilyMemberView(onAdd: { newMember in
                    familyMembers.append(newMember)
                    saveFamilyMembers()
                })
            }
        }
    }

    private func loadFamilyMembers() {
        if let data = UserDefaults.standard.data(forKey: "familyMembers"),
           let savedMembers = try? JSONDecoder().decode([FamilyMember].self, from: data) {
            familyMembers = savedMembers
        }
    }

    private func saveFamilyMembers() {
        if let data = try? JSONEncoder().encode(familyMembers) {
            UserDefaults.standard.set(data, forKey: "familyMembers")
        }
    }
}

#Preview {
    ContentView()
        .accessibilityLabel("Label")
}

