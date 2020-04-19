import Foundation
import SwiftShell

protocol BashRunning {
    func run(bash: String)
}

final class Bash: BashRunning {
    func run(bash: String) {
        main.run(bash: bash)
    }
}
