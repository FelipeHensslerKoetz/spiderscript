# frozen_string_literal: true

require 'rly'

class Lexer < Rly::Lex
  token :NEXT, /E QUEM DISSE QUE ISSO E PROBLEMA MEU\?/
  token :BREAK, /HAHAHA, EU ESTOU FORA\?/
  token :RETURN, /SEGURA O TROCO!/
  token :EMPTY_BLOCK, /\{\}/
  token :COMMA, /,/
  token :FOR, /O VERDADEIRO CRIME SERIA NAO TERMINA O QUE COMECAMOS/
  token :WHILE, /VAMOS TER QUE REFAZER DESDE A FORMULA\?/
  token :FUNCTION_DEFINITION, /COM GRANDES PODERES VEM GRANDES RESPONSABILIDADES/
  token :OPEN_BRACKET, /\{/
  token :CLOSE_BRACKET, /\}/
  token :IF, /VAI TEIA!/
  token :ELSE, /SHAZAM!/
  token :ELSIF, /PARA O ALTO E AVANTE TEIA!/
  token :PRINT, /CLARIM DIARIO INFORMA/
  token :OPEN_PARENTHESIS, /\(/
  token :CLOSE_PARENTHESIS, /\)/
  token :PLUS_ASSIGN, /\+=/
  token :PLUS, /\+/
  token :MINUS_ASSIGN, /-=/
  token :MINUS, /-/
  token :EXPONENT_ASSIGN, /\*\*=/
  token :EXPONENT, /\*\*/
  token :MULTIPLY_ASSIGN, /\*=/
  token :MULTIPLY, /\*/
  token :DIVIDE_ASSIGN, /\/=/
  token :DIVIDE, /\//
  token :MODULUS_ASSIGN, /%=/
  token :MODULUS, /%/
  token :AND, /&&/
  token :OR, /\|\|/
  token :NOT_EQUAL, /!=/
  token :NOT, /!/
  token :EQUAL, /==/
  token :LESS_THAN_OR_EQUAL, /<=/
  token :LESS_THAN, /</
  token :GREATER_THAN_OR_EQUAL, />=/
  token :GREATER_THAN, />/
  token :BOOLEAN, /true|false/
  token :FLOAT, /\d+\.\d+/
  token :INTEGER, /\d+/
  token :STRING, /"[^"]*"/ do |t|
    t.value = t.value[1..-2]
    t
  end
  token :END_OF_STATEMENT, /;/
  token :ASSIGN, /=/
  token :IDENTIFIER, /[a-zA-Z_]\w*/

  ignore " \t\n"

  on_error do |t|
    puts "Illegal character #{t.value}"
    raise StandardError, "Illegal character #{t.value}"
  end
end
