public class Lexer {
    var input: String
    var position: String.Index
    var readPosition: String.Index
    var ch: Character? = nil

    public init(input: String) {
        self.input = input
        self.position = input.startIndex
        self.readPosition = input.startIndex
        readChar()  // Set the first character
    }

    public func nextToken() -> Token {
        var tok: Token

        skipWhitespace()

        switch ch {
            case "=":
                if peekChar() == "=" {
                    let currentChar = ch
                    readChar()  // Advance to the next character
                    let literal = String(currentChar!) + String(currentChar!)
                    tok = Token(type: .EQ, literal: literal)
                } else {
                    tok = newToken(tokenType: .ASSIGN, ch: ch!)
                }
            case "+":
                tok = newToken(tokenType: .PLUS, ch: ch!)
            case "-":
                tok = newToken(tokenType: .MINUS, ch: ch!)
            case "!":
                if peekChar() == "=" {
                    let currentChar = ch
                    readChar()  // Advance to the next character
                    let literal = String(currentChar!) + String(ch!)
                    tok = Token(type: .NOT_EQ, literal: literal)
                } else {
                    tok = newToken(tokenType: .BANG, ch: ch!)
                }
            case "/":
                tok = newToken(tokenType: .SLASH, ch: ch!)
            case "*":
                tok = newToken(tokenType: .ASTERISK, ch: ch!)
            case "<":
                tok = newToken(tokenType: .LT, ch: ch!)
            case ">":
                tok = newToken(tokenType: .GT, ch: ch!)
            case ";":
                tok = newToken(tokenType: .SEMICOLON, ch: ch!)
            case ",":
                tok = newToken(tokenType: .COMMA, ch: ch!)
            case "(":
                tok = newToken(tokenType: .LPAREN, ch: ch!)
            case ")":
                tok = newToken(tokenType: .RPAREN, ch: ch!)
            case "{":
                tok = newToken(tokenType: .LBRACE, ch: ch!)
            case "}":
                tok = newToken(tokenType: .RBRACE, ch: ch!)
            case nil:
                tok = Token(type: .EOF, literal: "")
            default:
                if isLetter(ch: ch!) {
                    let identifier = readIdentifier()

                    tok = Token(type: lookupIdent(identifier), literal: identifier)

                    return tok
                } else if isDigit(ch: ch!) {
                    tok = Token(type: .INT, literal: readNumber())

                    return tok
                } else {
                    tok = newToken(tokenType: .ILLEGAL, ch: ch!)
                }
        }

        readChar()  // Advance to the next character
        return tok
    }

    func readChar() {
        if readPosition >= input.endIndex {
            ch = nil
        } else {
            ch = input[readPosition]
        }

        position = readPosition

        if readPosition < input.endIndex {
            readPosition = input.index(after: readPosition)
        }
    }

    func peekChar() -> Character? {
        if readPosition >= input.endIndex {
            return nil
        } else {
            return input[readPosition]
        }
    }

    func newToken(tokenType: TokenType, ch: Character) -> Token {
        return Token.init(type: tokenType, literal: String(ch))
    }

    func isLetter(ch: Character) -> Bool {
        return ("a" <= ch && ch <= "z") || ("A" <= ch && ch <= "Z") || (ch == "_")
    }

    func readIdentifier() -> String {
        let start = position

        // Continue reading characters while they are valid letters
        while isLetter(ch: ch!) {
            readChar()  // Advance to the next character
        }

        // Use the saved start index and the updated position to create a substring
        return String(input[start..<position])
    }

    func skipWhitespace() {
        // While the current character is a space, tab, newline, or carriage return, keep reading the next character
        while ch == " " || ch == "\t" || ch == "\n" || ch == "\r" {
            readChar()  // Advance to the next character
        }
    }

    func isDigit(ch: Character) -> Bool {
        return "0" <= ch && ch <= "9"
    }

    func readNumber() -> String {
        let start = position

        while isDigit(ch: ch!) {
            readChar()  // Advance to the next character
        }

        return String(input[start..<position])
    }
}
