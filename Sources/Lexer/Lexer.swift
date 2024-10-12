public class Lexer {
    var input: String
    var position = 0
    var readPosition = 0
    var ch: Character? = nil

    public init(input: String) {
        self.input = input
        readChar()
    }

    public func readChar() {
        if readPosition >= input.count {
            ch = nil
        } else {
            ch = input[input.index(input.startIndex, offsetBy: readPosition)]
        }

        position = readPosition
        readPosition += 1
    }

     public func newToken(tokenType: TokenType, ch: Character) -> Token {
        return Token.init(type: tokenType, literal: String(ch))
    }


    public func nextToken() -> Token {
        var tok: Token

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
            tok = Token(type: .ILLEGAL, literal: String(ch!))
        }

        readChar()
        return tok
    }
}