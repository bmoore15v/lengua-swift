import Foundation

let PROMPT = ">>"

public func Start(input: FileHandle, output: FileHandle) {

    while true {
        if let promptData = PROMPT.data(using: .utf8) {
            output.write(promptData)
        }

        // Read input from FileHandle as data
        guard let line = readLineFromFileHandle(fileHandle: input) else {
            break  // Stop if there's no input
        }

        // Initialize lexer with tht line
        let lexer = Lexer(input: line)

        // Process tokens from the lexer
        var token = lexer.nextToken()

        while token.type != .EOF {
            // Print the token to the output
            let tokenString = "\(token)\n"
            if let tokenData = tokenString.data(using: .utf8) {
                output.write(tokenData)
            }
            token = lexer.nextToken()
        }
    }
}

// Function to read a line of text from the FileHandle
func readLineFromFileHandle(fileHandle: FileHandle) -> String? {
    var inputData = Data()

    // Read one byte at a time until we hit a newline or EOF
    while true {
        let data = fileHandle.readData(ofLength: 1)
        if data.isEmpty {
            break
        }

        if let char = String(data: data, encoding: .utf8), char == "\n" {
            break
        }

        inputData.append(data)
    }

    // Convert the collected data to a string
    return String(data: inputData, encoding: .utf8)
}
