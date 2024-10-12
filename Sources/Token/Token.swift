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
}

let keywords: [String: TokenType] = [
    "fn": .FUNCTION,
    "let": .LET
]

public func lookupIdent(_ ident: String) -> TokenType {
    if let tokenType = keywords[ident] {
        return tokenType
    }
    return .IDENT
}