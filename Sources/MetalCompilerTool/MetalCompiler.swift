import ArgumentParser
import Foundation
import os

@main
struct MetalCompilerTool: ParsableCommand {
    @Option(name: .long)
    var output: String

    @Option(name: .long)
    var cache: String

    @Argument
    var inputs: [String]

    mutating func run() throws {
        let p = Process()
        p.executableURL = URL(fileURLWithPath: "/usr/bin/xcrun")
        p.arguments = [
            "metal",
        ]
            + inputs
            + [
                "-std=metal3.2",
                "-target",
                "air64-apple-macos15",
                "-o",
                output,
                "-gline-tables-only",
                "-frecord-sources=flat",
                "-fmetal-enable-logging",
            ]
            + ["-fmodules-cache-path=\(cache)"]
        try p.run()
    }
}
