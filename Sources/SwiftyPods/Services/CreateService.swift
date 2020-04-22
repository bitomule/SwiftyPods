import Foundation
import Storage
import PackageBuilder
import SwiftShell

final class CreateService {
    private enum Constant {
        static let fileName = "podfile.swift"
    }
    private let storage: FileSysteming
    private let template: String
    
    init(storage: FileSysteming = FileSystem(),
         template: String = emptyPodfileTemplate) {
        self.storage = storage
        self.template = template
    }
    
    func run(path: String?) throws {
        let url: URL
        if let path = path {
            url = URL(fileURLWithPath: path, isDirectory: true)
        } else {
            url = URL(fileURLWithPath: "", isDirectory: true)
        }
        try storage.saveFile(name: Constant.fileName, path: url, content: template, overwrite: false)
    }
 }
