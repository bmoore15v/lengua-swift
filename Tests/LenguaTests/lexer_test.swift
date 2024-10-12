import XCTest
import LenguaInterpreter

public class LexerTests: XCTestCase {
    func testNextToken() {
        let input = """
        let five = 5;
        let ten = 10;

        let add = fn(x, y) {
            x + y
        };

        let result = add(five, ten);

        !-/*5;
        5 < 10 > 5;

        if (5 < 10) {
            return true;
        } else {
            return false;
        }

        10 == 10;
        10 != 9;
        """

        let tests: [(expectedType: LenguaInterpreter.TokenType, expectedLiteral: String)] = [
            // First expression
            (.LET, "let"),
            (.IDENT, "five"),
            (.ASSIGN, "="),
            (.INT, "5"),
            (.SEMICOLON, ";"),

            // Second expression
            (.LET, "let"),
            (.IDENT, "ten"),
            (.ASSIGN, "="),
            (.INT, "10"),
            (.SEMICOLON, ";"),

            // Third expression
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

            // Fourth expression
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

            // Fifth expression
            (.BANG, "!"),
            (.MINUS, "-"),
            (.SLASH, "/"),
            (.ASTERISK, "*"),
            (.INT, "5"),
            (.SEMICOLON, ";"),

            // Sixth expression
            (.INT, "5"),
            (.LT, "<"),
            (.INT, "10"),
            (.GT, ">"),
            (.INT, "5"),
            (.SEMICOLON, ";"),

            // Seventh expression
            (.IF, "if"),
            (.LPAREN, "("),
            (.INT, "5"),
            (.LT, "<"),
            (.INT, "10"),
            (.RPAREN, ")"),
            (.LBRACE, "{"),
            (.RETURN, "return"),
            (.TRUE, "true"),
            (.SEMICOLON, ";"),
            (.RBRACE, "}"),
            (.ELSE, "else"),
            (.LBRACE, "{"),
            (.RETURN, "return"),
            (.FALSE, "false"),
            (.SEMICOLON, ";"),
            (.RBRACE, "}"),

            // Eighth expression
            (.INT, "10"),
            (.EQ, "=="),
            (.INT, "10"),
            (.SEMICOLON, ";"),

            // Ninth expression
            (.INT, "10"),
            (.NOT_EQ, "!="),
            (.INT, "9"),
            (.SEMICOLON, ";"),
            (.EOF, "")
        ]
        
        let lexer = LenguaInterpreter.Lexer(input: input)
        
        for (i, tt) in tests.enumerated() {
            let token = lexer.nextToken()
            
            XCTAssertEqual(token.type, tt.expectedType, "Test \(i): TokenType wrong. Expected \(tt.expectedType), got \(token.type)")
            XCTAssertEqual(token.literal, tt.expectedLiteral, "Test \(i): Literal wrong. Expected \(tt.expectedLiteral), got \(token.literal)")
        }
    }
}
