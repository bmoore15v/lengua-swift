public class Lexer {
    var input: String
    var position: Int = 0
    var readPosition: Int = 0
    var ch: Character? = nil

    public init(input: String) {
        self.input = input
        readChar()
    }

    func readChar() {
        if readPosition >= input.count {
            ch = nil
        } else {
            ch = input[input.index(input.startIndex, offsetBy: readPosition)]
        }

        position = readPosition
        readPosition += 1
    }

    func newToken(tokenType: TokenType, ch: Character) -> Token {
        return Token.init(type: tokenType, literal: String(ch))
    }

    func isLetter(ch: Character) -> Bool {
        return ("a" <= ch && ch <= "z") || ("A" <= ch && ch <= "Z") || (ch == "_")
    }

    public func readIdentifier() -> String {
        let start = position
        while let char = ch, isLetter(ch: char) {
            readChar()
        }
        let startIndex = input.index(input.startIndex, offsetBy: start)
        let endIndex = input.index(input.startIndex, offsetBy: position)
        return String(input[startIndex..<endIndex])
    }

    func skipWhitespace() {
    // While the current character is a space, tab, newline, or carriage return, keep reading the next character
    while let currentChar = ch, currentChar == " " || currentChar == "\t" || currentChar == "\n" || currentChar == "\r" {
        readChar() // Advance to the next character
    }
}

    func isDigit(ch: Character) -> Bool {
        return "0" <= ch && ch <= "9"
    }

    func readNumber() -> String {
        let start = position
        while let currentChar = ch, isDigit(ch: currentChar) {
            readChar()
        }
        let startIndex = input.index(input.startIndex, offsetBy: start)
        let endIndex = input.index(input.startIndex, offsetBy: position)
        return String(input[startIndex..<endIndex])
    }


    public func nextToken() -> Token {
        var tok: Token

        skipWhitespace()

        switch ch {
            case "=":
                tok = newToken(tokenType: .ASSIGN, ch: ch!)
            case ";":
                tok = newToken(tokenType: .SEMICOLON, ch: ch!)
            case "(":
                tok = newToken(tokenType: .LPAREN, ch: ch!)
            case ")":
                tok = newToken(tokenType: .RPAREN, ch: ch!)
            case ",":
                tok = newToken(tokenType: .COMMA, ch: ch!)
            case "+":
                tok = newToken(tokenType: .PLUS, ch: ch!)
            case "{":
                tok = newToken(tokenType: .LBRACE, ch: ch!)
            case "}":
                tok = newToken(tokenType: .RBRACE, ch: ch!)
            case nil:
                tok = Token(type: .EOF, literal: "")
            default:
                if isLetter(ch: ch ?? "2") {
                    let identifier = readIdentifier()
                    tok = Token(type: lookupIdent(identifier), literal: identifier)
                    return tok
                } else if isDigit(ch: ch ?? "3") {
                    tok = Token(type: .INT, literal: readNumber())
                    return tok
                } else {
                    tok = newToken(tokenType: .ILLEGAL, ch: ch!)
                }
        }

        readChar()
        return tok
    }
}