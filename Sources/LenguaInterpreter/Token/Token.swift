public struct Token {
    public let type: TokenType
    public var literal: String
}

public enum TokenType: String, Sendable {
    case ILLEGAL = "ILLEGAL"
    case EOF = "EOF"

    // Identifiers + literals
    case IDENT = "IDENT"
    case INT = "INT"

    // Operators
    case ASSIGN = "="
    case PLUS = "+"
    case MINUS = "-"
    case BANG = "!"
    case ASTERISK = "*"
    case SLASH = "/"
    case LT = "<"
    case GT = ">"
    case EQ = "=="
    case NOT_EQ = "!="

    // Delimiters
    case COMMA = ","
    case SEMICOLON = ";"
    case LPAREN = "("
    case RPAREN = ")"
    case LBRACE = "{"
    case RBRACE = "}"

    // Keywords
    case FUNCTION = "FUNCTION"
    case LET = "LET"
    case TRUE = "TRUE"
    case FALSE = "FALSE"
    case IF = "IF"
    case ELSE = "ELSE"
    case RETURN = "RETURN"
}

let keywords: [String: TokenType] = [
    "fn": .FUNCTION,
    "let": .LET,
    "true": .TRUE,
    "false": .FALSE,
    "if": .IF,
    "else": .ELSE,
    "return": .RETURN
]

public func lookupIdent(_ ident: String) -> TokenType {
    if let tokenType = keywords[ident] {
        return tokenType
    }
    return .IDENT
}