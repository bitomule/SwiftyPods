import Foundation
import PackageBuilder

final class EditService {
    private let packageBuilder: PackageBuilding
    
    init(packageBuilder: PackageBuilding = PackageBuilder()) {
        self.packageBuilder = packageBuilder
    }
    
    func run() throws {
        try packageBuilder.build(from: URL(fileURLWithPath: "", isDirectory: true))
    }
 }
