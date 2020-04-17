import Foundation
import Storage
import PodsDSL
import TemplateRenderer

public func buildPodfile(podfiles: [Podfile], path: String) throws {
    // Check folder exists
    let url = URL(fileURLWithPath: path, isDirectory: true)
    let context = ContentBuilder().build(podfiles: podfiles)
    let template = try TemplateRenderer().render(
        template: podfileTemplate,
        context: context
    )
    try FileSystem().saveFile(name: "podfile", path: url, content: template, overwrite: true)
}
