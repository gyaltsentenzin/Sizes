import Foundation
import SwiftUI

struct FamilyMember: Identifiable, Codable {
    let id: UUID
    let name: String
    let imageData: Data?
    let shoeSize: String
    let waist: String
    let chest: String
    let inseam: String
    let height: String

    init(id: UUID = UUID(), name: String, imageData: Data?, shoeSize: String, waist: String, chest: String, inseam: String, height: String) {
        self.id = id
        self.name = name
        self.imageData = imageData
        self.shoeSize = shoeSize
        self.waist = waist
        self.chest = chest
        self.inseam = inseam
        self.height = height
    }

    var image: UIImage? {
        if let data = imageData {
            return UIImage(data: data)
        }
        return nil
    }
}

