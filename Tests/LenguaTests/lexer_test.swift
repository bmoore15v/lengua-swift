import XCTest
import LenguaSwift

public class LexerTests: XCTestCase {
    func testNextToken() {
        let input = """
        let five = 5;
        let ten = 10;

        let add = fn(x, y) {
            x + y
        };

        let result = add(five, ten);
        """

        let tests: [(expectedType: LenguaSwift.TokenType, expectedLiteral: String)] = [
            (.LET, "let"),
            (.IDENT, "five"),
            (.ASSIGN, "="),
            (.INT, "5"),
            (.SEMICOLON, ";"),
            (.LET, "let"),
            (.IDENT, "ten"),
            (.ASSIGN, "="),
            (.INT, "10"),
            (.SEMICOLON, ";"),
            (.LET, "let"),
            (.IDENT, "add"),
            (.ASSIGN, "="),
            (.FUNCTION, "fn"),
            (.LPAREN, "("),
            (.IDENT, "x"),
            (.COMMA, ","),
            (.IDENT, "y"),
            (.RPAREN, ")"),
            (.LBRACE, "{"),
            (.IDENT, "x"),
            (.PLUS, "+"),
            (.IDENT, "y"),
            (.RBRACE, "}"),
            (.SEMICOLON, ";"),
            (.LET, "let"),
            (.IDENT, "result"),
            (.ASSIGN, "="),
            (.IDENT, "add"),
            (.LPAREN, "("),
            (.IDENT, "five"),
            (.COMMA, ","),
            (.IDENT, "ten"),
            (.RPAREN, ")"),
            (.SEMICOLON, ";"),
            (.EOF, "")
        ]

        // let input = """
        // let five = 5;
        // """
        
        // let tests: [(expectedType: LenguaSwift.TokenType, expectedLiteral: String)] = [
        //     (.LET, "let"),
        //     (.IDENT, "five"),
        //     (.ASSIGN, "="),
        //     (.INT, "5"),
        //     (.SEMICOLON, ";"),
        //     (.EOF, ""),
        // ]

        // let input = "=+(){},;"
        // let tests: [(expectedType: LenguaSwift.TokenType, expectedLiteral: String)] = [
        //     (.ASSIGN, "="),
        //     (.PLUS, "+"),
        //     (.LPAREN, "("),
        //     (.RPAREN, ")"),
        //     (.LBRACE, "{"),
        //     (.RBRACE, "}"),
        //     (.COMMA, ","),
        //     (.SEMICOLON, ";"),
        //     (.EOF, ""),
        // ]


        
        let lexer = LenguaSwift.Lexer(input: input)
        
        for (i, tt) in tests.enumerated() {
            let token = lexer.nextToken()
            
            XCTAssertEqual(token.type, tt.expectedType, "Test \(i): TokenType wrong. Expected \(tt.expectedType), got \(token.type)")
            XCTAssertEqual(token.literal, tt.expectedLiteral, "Test \(i): Literal wrong. Expected \(tt.expectedLiteral), got \(token.literal)")
        }
    }
}
