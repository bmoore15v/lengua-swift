import Foundation
import LenguaInterpreter

struct User {
    let username: String

    static func current() throws -> User {
        let user = NSUserName()  // Get the current user
        return User(username: user)
    }
}

// Entry point for your program
func main() {
    print("Welcome to the REPL!\n")

    // Get the current user
    let currentUser: String
    do {
        let user = try User.current()
        currentUser = user.username
    } catch {
        print("Error retrieving current user: \(error)")
        return
    }

    // Print welcome message
    print("Hello \(currentUser)! This is the Lengua programming language!")
    print("Feel free to type in commands")

    // Start the REPL
    Start(input: FileHandle.standardInput, output: FileHandle.standardOutput)
}

main()
