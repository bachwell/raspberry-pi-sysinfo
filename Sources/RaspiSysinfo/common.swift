
import Foundation


struct Command {
    let cmd: String
    let options: [String]
    let resolver: CLResolver
    
    func doCommand() -> CLResult {
        let proc = Process()
        proc.launchPath = cmd
        proc.arguments = options
        
        let pipe = Pipe()
        proc.standardOutput = pipe
        let pipeError = Pipe()
        proc.standardError = pipeError
        
        proc.launch()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()

        proc.waitUntilExit()

        return resolver.resolve(cmd: cmd, option: options.joined(separator: " "), data: data)
    }
}

struct CLResult {
    let title: String
    let result: [String: Any]
}

protocol CLResolver {
    func resolve(cmd: String, option: String, data: Data) -> CLResult
}
