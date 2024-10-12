import XCTest
import LenguaSwift

class LexerTests: XCTestCase {
    func testNextToken() {
        let input = "=+(){},;"
        
        let tests: [(expectedType: LenguaSwift.TokenType, expectedLiteral: String)] = [
            (.ASSIGN, "="),
            (.PLUS, "+"),
            (.LPAREN, "("),
            (.RPAREN, ")"),
            (.LBRACE, "{"),
            (.RBRACE, "}"),
            (.COMMA, ","),
            (.SEMICOLON, ";"),
            (.EOF, "")
        ]
        
        let lexer = LenguaSwift.Lexer(input: input)
        
        for (i, tt) in tests.enumerated() {
            let token = lexer.nextToken()
            
            XCTAssertEqual(token.type, tt.expectedType, "Test \(i): TokenType wrong. Expected \(tt.expectedType), got \(token.type)")
            XCTAssertEqual(token.literal, tt.expectedLiteral, "Test \(i): Literal wrong. Expected \(tt.expectedLiteral), got \(token.literal)")
        }
    }
}