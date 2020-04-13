import Foundation

protocol FileSymlinking {
    func linkFile(at: URL, toFolder: URL)
}

final class FileSimlinker: FileSymlinking {
    func linkFile(at: URL, toFolder: URL) {
        // Create symbolic link from file at URL to file at folder
    }
}
