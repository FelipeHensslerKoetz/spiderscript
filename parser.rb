require 'rly'
require 'pry'

class Parser < Rly::Yacc
  precedence :left, :PLUS, :MINUS
  precedence :left, :MULTIPLY, :DIVIDE, :MODULUS
  precedence :right, :EXPONENT

  # Program is a list of statements
  rule 'program : statement_list' do |a, b|
    a.value = b.value
  end

  # A statement list is a list of statements
  rule 'statement_list : statement_list statement' do |a, b, c|
    a.value = b.value + c.value
  end

  # A statement list is a single statement
  rule 'statement_list : statement' do |a, b|
    a.value = b.value
  end

  # Every statement should end with a semicolon
  rule 'statement : expression END_OF_STATEMENT' do |a, b|
    a.value = b.value
  end

  # Variable assignment
  rule 'expression : IDENTIFIER ASSIGN expression' do |a, b, _c, d|
    a.value = "#{b.value} = #{d.value}\n"
  end

  # String
  rule 'expression : STRING' do |a, b|
    a.value = "\"#{b.value}\""
  end

  # Integer
  rule 'expression : INTEGER' do |a, b|
    a.value = b.value
  end

  # Float
  rule 'expression : FLOAT' do |a, b|
    a.value = b.value
  end

  # Boolean
  rule 'expression : BOOLEAN' do |a, b|
    a.value = b.value
  end

  # Identifier
  rule 'expression : IDENTIFIER' do |a, b|
    a.value = b.value
  end

  # sum
  rule 'expression : expression PLUS expression' do |a, b, _c, d|
    a.value = "#{b.value} + #{d.value}"
  end

  # subtraction
  rule 'expression : expression MINUS expression' do |a, b, _c, d|
    a.value = "#{b.value} - #{d.value}"
  end

  # multiplication
  rule 'expression : expression MULTIPLY expression' do |a, b, _c, d|
    a.value = "#{b.value} * #{d.value}"
  end

  # division
  rule 'expression : expression DIVIDE expression' do |a, b, _c, d|
    a.value = "#{b.value} / #{d.value}"
  end

  # modulus
  rule 'expression : expression MODULUS expression' do |a, b, _c, d|
    a.value = "#{b.value} % #{d.value}"
  end

  # exponent
  rule 'expression : expression EXPONENT expression' do |e, e1, ex, e2|
    e.value = "#{e1.value} ** #{e2.value}"
  end

  # parenthesis expression
  rule 'expression : OPEN_PARENTHESIS expression CLOSE_PARENTHESIS' do |e, l, e2, r|
    e.value = "(#{e2.value})"
  end

  # greater than
  rule 'expression : expression GREATER_THAN expression' do |e, e1, gt, e2|
    e.value = "#{e1.value} > #{e2.value}"
  end

  # greater than or equal
  rule 'expression : expression GREATER_THAN_OR_EQUAL expression' do |e, e1, ge, e2|
    e.value = "#{e1.value} >= #{e2.value}"
  end

  # equal
  rule 'expression : expression EQUAL expression' do |e, e1, eq, e2|
    e.value = "#{e1.value} == #{e2.value}"
  end

  # not equal
  rule 'expression : expression NOT_EQUAL expression' do |e, e1, ne, e2|
    e.value = "#{e1.value} != #{e2.value}"
  end

  # less than
  rule 'expression : expression LESS_THAN expression' do |e, e1, lt, e2|
    e.value = "#{e1.value} < #{e2.value}"
  end

  # less than or equal
  rule 'expression : expression LESS_THAN_OR_EQUAL expression' do |e, e1, le, e2|
    e.value = "#{e1.value} <= #{e2.value}"
  end

  # AND operator
  rule 'expression : expression AND expression' do |e, e1, a, e2|
    e.value = "#{e1.value} && #{e2.value}"
  end

  # OR operator
  rule 'expression : expression OR expression' do |e, e1, o, e2|
    e.value = "#{e1.value} || #{e2.value}"
  end

  # NOT operator
  rule 'expression : NOT expression' do |e, n, e2|
    e.value = "!#{e2.value}"
  end

  # PLUS_ASSIGN operator
  rule 'expression : IDENTIFIER PLUS_ASSIGN expression' do |e, i, pa, e2|
    e.value = "#{i.value} += #{e2.value}\n"
  end

  # MINUS_ASSIGN operator
  rule 'expression : IDENTIFIER MINUS_ASSIGN expression' do |e, i, ma, e2|
    e.value = "#{i.value} -= #{e2.value}\n"
  end

  # MULTIPLY_ASSIGN operator
  rule 'expression : IDENTIFIER MULTIPLY_ASSIGN expression' do |e, i, ma, e2|
    e.value = "#{i.value} *= #{e2.value}\n"
  end

  # DIVIDE_ASSIGN operator
  rule 'expression : IDENTIFIER DIVIDE_ASSIGN expression' do |e, i, da, e2|
    e.value = "#{i.value} /= #{e2.value}\n"
  end

  # MODULUS_ASSIGN operator
  rule 'expression : IDENTIFIER MODULUS_ASSIGN expression' do |e, i, ma, e2|
    e.value = "#{i.value} %= #{e2.value}\n"
  end

  # EXPONENT_ASSIGN operator
  rule 'expression : IDENTIFIER EXPONENT_ASSIGN expression' do |e, i, ea, e2|
    e.value = "#{i.value} **= #{e2.value}\n"
  end

  # function call 
  rule 'expression : IDENTIFIER OPEN_PARENTHESIS expression_list CLOSE_PARENTHESIS' do |e, i, op, el, cp|
    e.value = "#{i.value}(#{el.value})"
  end

  # function call with no arguments
  rule 'expression : IDENTIFIER OPEN_PARENTHESIS CLOSE_PARENTHESIS' do |e, i, op, cp|
    e.value = "#{i.value}()"
  end

  # expression list
  rule 'expression_list : expression_list COMMA expression' do |el, el2, c, e|
    el.value = "#{el2.value},#{e.value}"
  end

  # single expression
  rule 'expression_list : expression' do |el, e|
    el.value = e.value
  end

  # PRINT
  rule 'expression : PRINT OPEN_PARENTHESIS expression CLOSE_PARENTHESIS' do |e, p, op, e2, cp|
    e.value = "puts(#{e2.value})\n"
  end

  # IF (empty block)
  rule 'expression : IF expression EMPTY_BLOCK' do |e, i, e2, ob, sl, cb|
    e.value = "if#{e2.value}\nend\n"
  end

  # IF (non-empty block)
  rule 'expression : IF expression OPEN_BRACKET statement_list CLOSE_BRACKET' do |e, i, e2, ob, sl, cb|
    e.value = "if#{e2.value}\n#{sl.value}end\n"
  end

  # IF (empty block) ELSE (empty block)
  rule 'expression : IF expression EMPTY_BLOCK ELSE EMPTY_BLOCK' do |e, i, e2, ob, sl, cb, el, ob2, sl2, cb2|
    e.value = "if#{e2.value}\nelse\nend\n"
  end

  # IF (non-empty block) ELSE (non-empty block)
  rule 'expression : IF expression OPEN_BRACKET statement_list CLOSE_BRACKET ELSE OPEN_BRACKET statement_list CLOSE_BRACKET' do |e, i, e2, ob, sl, cb, el, ob2, sl2, cb2|
    e.value = "if#{e2.value}\n#{sl.value}else\n#{sl2.value}end\n"
  end

  # IF (non-empty block) ELSE (empty block)
  rule 'expression : IF expression OPEN_BRACKET statement_list CLOSE_BRACKET ELSE EMPTY_BLOCK' do |e, i, e2, ob, sl, cb, el, ob2, sl2, cb2|
    e.value = "if#{e2.value}\n#{sl.value}else\nend\n"
  end

  # IF (empty block) ELSE (non-empty block)
  rule 'expression : IF expression EMPTY_BLOCK ELSE OPEN_BRACKET statement_list CLOSE_BRACKET' do |e, i, e2, eb, el, ob, sl, cb| 
    e.value = "if#{e2.value}\nelse\n#{sl.value}end\n"
  end

  # IF (present block) ELSIF (empty block)
  rule 'expression : IF expression OPEN_BRACKET statement_list CLOSE_BRACKET ELSIF expression EMPTY_BLOCK' do |e, i, e2, ob, sl, cb, el, e3, eb|
    e.value = "if#{e2.value}\n#{sl.value}elsif#{e3.value}\nend\n"
  end

  # IF (empty block) ELSIF (present block)
  rule 'expression : IF expression EMPTY_BLOCK ELSIF expression OPEN_BRACKET statement_list CLOSE_BRACKET' do |e,i, e2,eb,el,e3, ob, sl, cb|
    e.value = "if#{e2.value}\nelsif#{e3}\n#{sl.value}end\n"
  end

  # IF (empty block) ELSIF (empty block)
  rule 'expression : IF expression EMPTY_BLOCK ELSIF expression EMPTY_BLOCK' do |e, i, e2, eb, el, e3, eb2|
    e.value = "if#{e2.value}\nelsif#{e3.value}\nend\n"
  end

  # IF (present block) ELSIF (present block)
  rule 'expression : IF expression OPEN_BRACKET statement_list CLOSE_BRACKET ELSIF expression OPEN_BRACKET statement_list CLOSE_BRACKET' do |e, i, e2, ob, sl, cb, el, e3, ob2, sl2, cb2|
    e.value = "if#{e2.value}\n#{sl.value}elsif#{e3.value}\n#{sl2.value}end\n"
  end

  # IF (present block) ELSIF (any number of empty blocks)
  rule 'expression : IF expression OPEN_BRACKET statement_list CLOSE_BRACKET elsif_list' do |e, i, e2, ob, sl, cb, el|
    e.value = "if#{e2.value}\n#{sl.value}#{el.value}end\n"
  end

  # IF (empty block) ELSIF (any number of present blocks)
  rule 'expression : IF expression EMPTY_BLOCK elsif_list' do |e, i, e2, eb, el|
    e.value = "if#{e2.value}\n#{el.value}end\n"
  end

  # elsif list - 1 variant
  rule 'elsif_list : ELSIF expression EMPTY_BLOCK' do |el, e, e1, eb|
    el.value = "elsif#{e1.value}\n"
  end

  # elsif list - 2 variant
  rule 'elsif_list : elsif_list ELSIF expression EMPTY_BLOCK' do |el, el2, e, e1, eb|
    el.value = "#{el2.value}elsif#{e1.value}\n"
  end

  # elsif list - 3 variant
  rule 'elsif_list : ELSIF expression OPEN_BRACKET statement_list CLOSE_BRACKET' do |el, e, e1, ob, sl, cb|
    el.value = "elsif#{e1.value}\n#{sl.value}"
  end

  # elsif list - 4 variant
  rule 'elsif_list : elsif_list ELSIF expression OPEN_BRACKET statement_list CLOSE_BRACKET' do |el, el2, e, e1, ob, sl, cb|
    el.value = "#{el2.value}elsif#{e1.value}\n#{sl.value}"
  end

  # IF ELSIF (empty block) ELSE (empty block)
  rule 'expression : IF expression OPEN_BRACKET statement_list CLOSE_BRACKET ELSIF expression EMPTY_BLOCK ELSE EMPTY_BLOCK' do |e, i, e2, ob, sl, cb, el, e3, eb, el2, eb2|
    e.value = "if#{e2.value}\n#{sl.value}elsif#{e3.value}\nelse\nend\n"
  end

  # IF (empty block) ELSIF ELSE (empty block)
  rule 'expression : IF expression EMPTY_BLOCK ELSIF expression OPEN_BRACKET  statement_list CLOSE_BRACKET ELSE EMPTY_BLOCK' do |e, i, e2, eb, el, e3, eb2, el2, eb3|

  end
end