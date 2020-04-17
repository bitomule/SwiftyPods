import Foundation

public var podfiles = [Podfile]()

func +=(lhs: inout [Podfile], rhs: Podfile) {
    lhs += [rhs]
}
