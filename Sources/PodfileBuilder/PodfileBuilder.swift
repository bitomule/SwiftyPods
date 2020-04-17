import Foundation
import Storage
import PodsDSL
import TemplateRenderer

func buildPodfile(podfiles: [Podfile]) throws {
    let context = ContentBuilder().build(podfiles: podfiles)
    let template = try TemplateRenderer().render(
        template: podfileTemplate,
        context: context
    )
    try FileSystem().saveFile(name: "podfile", path: URL(fileURLWithPath: "", isDirectory: true), content: template, overwrite: true)
}
