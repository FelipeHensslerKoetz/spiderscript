# frozen_string_literal: true

require 'rly'
require 'pry'

# rubocop:disable Metrics/LineLength
# rubocop:disable Metrics/ClassLength
# rubocop:disable Style/Documentation
class Parser < Rly::Yacc
  def add_identation(yacc_symbol)
    "\s\s#{yacc_symbol.value.gsub("\n", "\n\s\s").sub(/\n\s\s$/, '')}\n"
  end

  rule 'program : statement_list' do |*args|
    args[0].value = args[1].value
  end

  rule 'statement_list : statement_list statement' do |*args|
    args[0].value = args[1].value + args[2].value
  end

  rule 'statement_list : statement' do |*args|
    args[0].value = args[1].value
  end

  rule 'statement : expression END_OF_STATEMENT' do |*args|
    args[0].value = args[1].value
  end

  rule 'expression : INTEGER
                   | FLOAT
                   | BOOLEAN
                   | IDENTIFIER' do |*args|
    args[0].value = args[1].value
  end

  rule 'expression : BREAK' do |*args|
    args[0].value = "break\n"
  end

  rule 'expression : STRING' do |*args|
    args[0].value = "\"#{args[1].value}\""
  end

  rule 'expression : NEXT' do |*args|
    args[0].value = 'next'
  end

  rule 'expression : expression PLUS expression
                   | expression MINUS expression
                   | expression MULTIPLY expression
                   | expression DIVIDE expression
                   | expression MODULUS expression
                   | expression EXPONENT expression
                   | expression GREATER_THAN expression
                   | expression GREATER_THAN_OR_EQUAL expression
                   | expression EQUAL expression
                   | expression NOT_EQUAL expression
                   | expression LESS_THAN expression
                   | expression LESS_THAN_OR_EQUAL expression
                   | expression AND expression
                   | expression OR expression' do |*args|
    args[0].value = "#{args[1].value} #{args[2].value} #{args[3].value}"
  end

  rule 'expression : OPEN_PARENTHESIS expression CLOSE_PARENTHESIS' do |*args|
    args[0].value = "(#{args[2].value})"
  end

  rule 'expression : NOT expression' do |*args|
    args[0].value = "!#{args[2].value}"
  end

  rule 'expression : IDENTIFIER PLUS_ASSIGN expression
                   | IDENTIFIER MINUS_ASSIGN expression
                   | IDENTIFIER MULTIPLY_ASSIGN expression
                   | IDENTIFIER DIVIDE_ASSIGN expression
                   | IDENTIFIER MODULUS_ASSIGN expression
                   | IDENTIFIER EXPONENT_ASSIGN expression
                   | IDENTIFIER ASSIGN expression' do |*args|
    args[0].value = "#{args[1].value} #{args[2].value} #{args[3].value}\n"
  end

  rule 'expression : IDENTIFIER OPEN_PARENTHESIS expression_list CLOSE_PARENTHESIS' do |*args|
    args[0].value = "#{args[1].value}#{args[2].value}#{args[3].value}#{args[4].value}"
  end

  rule 'expression : IDENTIFIER OPEN_PARENTHESIS CLOSE_PARENTHESIS' do |*args|
    args[0].value = "#{args[1].value}#{args[2].value}#{args[3].value}"
  end

  rule 'expression_list : expression_list COMMA expression' do |*args|
    args[0].value = "#{args[1].value}#{args[2].value}#{args[3].value}"
  end

  rule 'expression_list : expression' do |*args|
    args[0].value = args[1].value
  end

  rule 'expression : PRINT OPEN_PARENTHESIS expression CLOSE_PARENTHESIS' do |*args|
    args[0].value = "puts #{args[3].value}\n"
  end

  rule 'expression : RETURN OPEN_PARENTHESIS expression CLOSE_PARENTHESIS' do |*args|
    args[0].value = "return #{args[3].value}\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    args[0].value = "if #{args[3].value}\nend\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    if_block = add_identation(args[6])
    args[0].value = "if #{args[3].value}\n#{if_block}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSE EMPTY_BLOCK' do |*args|
    args[0].value = "if #{args[3].value}\nelse\nend\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSE OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    if_block = add_identation(args[6])
    else_statement_list = add_identation(args[10])
    args[0].value = "if #{args[3].value}\n#{if_block}else\n#{else_statement_list}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSE EMPTY_BLOCK' do |*args|
    if_block = add_identation(args[6])
    args[0].value = "if #{args[3].value}\n#{if_block}else\nend\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSE OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    else_statement_list = add_identation(args[8])
    args[0].value = "if #{args[3].value}\nelse\n#{else_statement_list}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    if_block = add_identation(args[6])
    args[0].value = "if #{args[3].value}\n#{if_block}elsif #{args[10].value}\nend\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    elsif_block = add_identation(args[11])
    args[0].value = "if #{args[3].value}\nelsif #{args[8]}\n#{elsif_block}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    args[0].value = "if #{args[3].value}\nelsif #{args[8].value}\nend\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    if_block = add_identation(args[6])
    elsif_block = add_identation(args[13])

    args[0].value = "if #{args[3].value}\n#{if_block}elsif #{args[10]}\n#{elsif_block}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET elsif_list' do |*args|
    if_block = add_identation(args[6])
    args[0].value = "if #{args[3].value}\n#{if_block}#{args[8]}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK elsif_list' do |*args|
    args[0].value = "if #{args[3].value}\n#{args[6].value}end\n"
  end

  rule 'elsif_list : ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    args[0].value = "elsif #{args[3].value}\n"
  end

  rule 'elsif_list : elsif_list ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    args[0].value = "#{args[1].value}elsif #{args[4].value}\n"
  end

  rule 'elsif_list : ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    elsif_block = add_identation(args[6])
    args[0].value = "elsif #{args[3].value}\n#{elsif_block}"
  end

  rule 'elsif_list : elsif_list ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    elsif_block = add_identation(args[7])
    args[0].value = "#{args[1].value}elsif #{args[4].value}\n#{elsif_block}"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSE EMPTY_BLOCK' do |*args|
    if_block = add_identation(args[6])
    args[0].value = "if #{args[3].value}\n#{if_block}elsif #{args[10].value}\nelse\nend\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET  statement_list CLOSE_BRACKET ELSE EMPTY_BLOCK' do |*args|
    elsif_block = add_identation(args[11])
    args[0].value = "if #{args[3].value}\nelsif #{args[8].value}\n#{elsif_block}else\nend\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSE OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    else_statement_list = add_identation(args[13])
    args[0].value = "if #{args[3].value}\nelsif #{args[8].value}\nelse\n#{else_statement_list}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSE OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    if_block = add_identation(args[6])
    elsif_block = add_identation(args[13])
    else_statement_list = add_identation(args[17])

    args[0].value = "if #{args[3].value}\n#{if_block}elsif #{args[10]}\n#{elsif_block}else\n#{else_statement_list}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSE EMPTY_BLOCK' do |*args|
    args[0].value = "if #{args[3].value}\nelsif #{args[8].value}\nelse\nend\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSE EMPTY_BLOCK' do |*args|
    if_block = add_identation(args[6])
    elsif_block = add_identation(args[13])
    args[0].value = "if #{args[3].value}\n#{if_block}elsif #{args[10].value}\n#{elsif_block}else\nend\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSE OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    if_block = add_identation(args[6])
    else_statement_list = add_identation(args[15])
    args[0].value = "if #{args[3].value}\n#{if_block}elsif #{args[10].value}\nelse\n#{else_statement_list}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK ELSIF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET ELSE OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    elsif_block = add_identation(args[11])
    else_statement_list = add_identation(args[15])
    args[0].value = "if #{args[3].value}\nelsif #{args[8].value}\n#{elsif_block}else\n#{else_statement_list}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET elsif_list ELSE EMPTY_BLOCK' do |*args|
    if_block = add_identation(args[6])
    args[0].value = "if #{args[3].value}\n#{if_block}#{args[8].value}else\nend\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET elsif_list ELSE OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    if_block = add_identation(args[6])
    else_statement_list = add_identation(args[11])
    args[0].value = "if #{args[3].value}\n#{if_block}#{args[8].value}else\n#{else_statement_list}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK elsif_list ELSE OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    elsif_block = add_identation(args[9])
    args[0].value = "if #{args[3].value}\n#{args[6].value}else\n#{elsif_block}end\n"
  end

  rule 'expression : IF OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK elsif_list ELSE EMPTY_BLOCK' do |*args|
    args[0].value = "if #{args[3].value}\n#{args[6].value}else\nend\n"
  end

  rule 'expression : FUNCTION_DEFINITION IDENTIFIER OPEN_PARENTHESIS CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    args[0].value = "def #{args[2].value}\nend\n"
  end

  rule 'expression : FUNCTION_DEFINITION IDENTIFIER OPEN_PARENTHESIS CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    function_statement_list = add_identation(args[6])

    args[0].value = "def #{args[2].value}\n#{function_statement_list}end\n"
  end

  rule 'expression : FUNCTION_DEFINITION IDENTIFIER OPEN_PARENTHESIS IDENTIFIER CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    args[0].value = "def #{args[2].value}(#{args[4].value})\nend\n"
  end

  rule 'expression : FUNCTION_DEFINITION IDENTIFIER OPEN_PARENTHESIS IDENTIFIER CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    function_statement_list = add_identation(args[7])
    args[0].value = "def #{args[2].value}(#{args[4].value})\n#{function_statement_list}end\n"
  end

  rule 'expression : FUNCTION_DEFINITION IDENTIFIER OPEN_PARENTHESIS expression_list CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    args[0].value = "def #{args[2].value}(#{args[4].value})\nend\n"
  end

  rule 'expression : FUNCTION_DEFINITION IDENTIFIER OPEN_PARENTHESIS expression_list CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    function_statement_list = add_identation(args[7])
    args[0].value = "def #{args[2].value}(#{args[4].value})\n#{function_statement_list}end\n"
  end

  rule 'expression : WHILE OPEN_PARENTHESIS expression CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    args[0].value = "while #{args[3].value}\nend\n"
  end

  rule 'expression : WHILE OPEN_PARENTHESIS expression CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    while_statement_list = add_identation(args[6])
    args[0].value = "while #{args[3].value}\n#{while_statement_list}end\n"
  end

  rule 'expression : FOR OPEN_PARENTHESIS INTEGER CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    args[0].value = "#{args[3]}.times do\nend\n"
  end

  rule 'expression : FOR OPEN_PARENTHESIS INTEGER CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    for_statement_list = add_identation(args[6])
    args[0].value = "#{args[3]}.times do\n#{for_statement_list}end\n"
  end

  rule 'expression : FOR OPEN_PARENTHESIS INTEGER COMMA IDENTIFIER CLOSE_PARENTHESIS EMPTY_BLOCK' do |*args|
    args[0].value = "#{args[3]}.times do |#{args[5].value}|\nend\n"
  end

  rule 'expression : FOR OPEN_PARENTHESIS INTEGER COMMA IDENTIFIER CLOSE_PARENTHESIS OPEN_BRACKET statement_list CLOSE_BRACKET' do |*args|
    for_statement_list = add_identation(args[8])
    args[0].value = "#{args[3]}.times do |#{args[5].value}|\n#{for_statement_list}end\n"
  end
end
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/ClassLength
# rubocop:enable Style/Documentation
