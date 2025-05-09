public protocol Node {
    func tokenLiteral() -> String
}

public protocol Statement: Node {
    func statementNode()
}

public protocol Expression: Node {
    func expressionNode()
}

public struct Program {
    public var statements: [Statement]
    
    public init(statements: [Statement] = []) {
        self.statements = statements
    }
    
    public func tokenLiteral() -> String {
        if !statements.isEmpty {
            return statements[0].tokenLiteral()
        }
        return ""
    }
}

public struct LetStatement: Statement {
    public let token: Token // the LET token
    public let name: Identifier
    public let value: Expression
    
    public init(token: Token, name: Identifier, value: Expression) {
        self.token = token
        self.name = name
        self.value = value
    }
    
    public func statementNode() {}
    
    public func tokenLiteral() -> String {
        return token.literal
    }
}

public struct Identifier: Expression {
    public let token: Token // the IDENT token
    public let value: String
    
    public init(token: Token, value: String) {
        self.token = token
        self.value = value
    }
    
    public func expressionNode() {}
    
    public func tokenLiteral() -> String {
        return token.literal
    }
}