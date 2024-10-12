public struct Token {
    public let type: TokenType
    public let literal: String
}

public enum TokenType: String {
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