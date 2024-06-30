# frozen_string_literal: true

require 'spec_helper'
require_relative '../lexer'
require 'pry'

# rubocop:disable Metrics/BlockLength
# rubocop:disable Lint/NestedPercentLiteral
RSpec.describe Lexer do
  subject(:lexer) { described_class.new(input) }

  let(:input) { '' }

  it 'is a subclass of Rly::Lex' do
    expect(lexer).to be_a(Rly::Lex)
  end

  context 'when tokenizing' do
    describe 'next' do
      let(:input) { 'E QUEM DISSE QUE ISSO É PROBLEMA MEU?' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:NEXT)
        expect(token.value).to eq('E QUEM DISSE QUE ISSO É PROBLEMA MEU?')
      end
    end

    describe 'break' do
      let(:input) { 'OLHA O DUENDE JÚNIOR, VAI CHORAR?' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:BREAK)
        expect(token.value).to eq('OLHA O DUENDE JÚNIOR, VAI CHORAR?')
      end
    end

    describe 'return' do
      let(:input) { 'SEGURA O TROCO!' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:RETURN)
        expect(token.value).to eq('SEGURA O TROCO!')
      end
    end

    describe 'identifier' do
      let(:input) { 'custom_variable' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:IDENTIFIER)
        expect(token.value).to eq('custom_variable')
      end
    end

    describe 'invalid identifier' do
      let(:input) { '#custom_variable' }

      it 'returns the correct token' do
        expect { lexer.next }.to raise_error(StandardError, 'Illegal character #')
      end
    end

    describe 'equal' do
      let(:input) { '==' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:EQUAL)
        expect(token.value).to eq('==')
      end
    end

    context 'empty block' do
      let(:input) { '{}' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:EMPTY_BLOCK)
        expect(token.value).to eq('{}')
      end
    end

    context 'open bracket' do
      let(:input) { '{' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:OPEN_BRACKET)
        expect(token.value).to eq('{')
      end
    end

    context 'close bracket' do
      let(:input) { '}' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:CLOSE_BRACKET)
        expect(token.value).to eq('}')
      end
    end

    context 'open parenthesis' do
      let(:input) { '(' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:OPEN_PARENTHESIS)
        expect(token.value).to eq('(')
      end
    end

    context 'close parenthesis' do
      let(:input) { ')' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:CLOSE_PARENTHESIS)
        expect(token.value).to eq(')')
      end
    end

    context 'print function call' do
      let(:input) { 'CLARIM DIÁRIO INFORMA' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:PRINT)
        expect(token.value).to eq('CLARIM DIÁRIO INFORMA')
      end
    end

    context 'if' do
      let(:input) { 'VAI TEIA!' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:IF)
        expect(token.value).to eq('VAI TEIA!')
      end
    end

    context 'else' do
      let(:input) { 'SHAZAM!' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:ELSE)
        expect(token.value).to eq('SHAZAM!')
      end
    end

    context 'elsif' do
      let(:input) { 'PARA O ALTO E AVANTE TEIA!' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:ELSIF)
        expect(token.value).to eq('PARA O ALTO E AVANTE TEIA!')
      end
    end

    context 'assignment operators' do
      let(:input) { '= += *= -= /= %= **=' }

      it 'returns the correct token' do
        lex_tokens = []

        7.times do
          lex_tokens << lexer.next
        end

        expect(lex_tokens.map(&:type)).to eq(%i[ASSIGN PLUS_ASSIGN MULTIPLY_ASSIGN MINUS_ASSIGN DIVIDE_ASSIGN
                                                MODULUS_ASSIGN EXPONENT_ASSIGN])
        expect(lex_tokens.map(&:value)).to eq(%w[= += *= -= /= %= **=])
      end
    end

    context 'logical operators' do
      let(:input) { '&& || !' }

      it 'returns the correct tokens' do
        lex_tokens = []

        3.times do
          lex_tokens << lexer.next
        end

        expect(lex_tokens.map(&:type)).to eq(%i[AND OR NOT])
        expect(lex_tokens.map(&:value)).to eq(%w[&& || !])
      end
    end

    context 'comparison operators' do
      let(:input) { '== != <= < >= >' }

      it 'returns the correct tokens' do
        lex_tokens = []

        6.times do
          lex_tokens << lexer.next
        end

        expect(lex_tokens.map(&:type)).to eq(%i[EQUAL NOT_EQUAL LESS_THAN_OR_EQUAL LESS_THAN GREATER_THAN_OR_EQUAL
                                                GREATER_THAN])
        expect(lex_tokens.map(&:value)).to eq(%w[== != <= < >= >])
      end
    end

    context 'mathematical operators' do
      let(:input) { '+ - * / % **' }

      it 'returns the correct tokens' do
        lex_tokens = []

        6.times do
          lex_tokens << lexer.next
        end

        expect(lex_tokens.map(&:type)).to eq(%i[PLUS MINUS MULTIPLY DIVIDE MODULUS EXPONENT])
        expect(lex_tokens.map(&:value)).to eq(%w[+ - * / % **])
      end
    end

    context 'integer numbers' do
      let(:input) { '1 2 3 4' }

      it 'returns the correct tokens' do
        lex_tokens = []

        4.times do
          lex_tokens << lexer.next
        end

        expect(lex_tokens.map(&:type)).to eq(%i[INTEGER INTEGER INTEGER INTEGER])
        expect(lex_tokens.map(&:value)).to eq(%w[1 2 3 4])
      end
    end

    context 'booleans' do
      let(:input) { 'true false' }

      it 'returns the correct tokens' do
        lex_tokens = []

        2.times do
          lex_tokens << lexer.next
        end

        expect(lex_tokens.map(&:type)).to eq(%i[BOOLEAN BOOLEAN])
        expect(lex_tokens.map(&:value)).to eq(%w[true false])
      end
    end

    context 'float numbers' do
      let(:input) { '1.2 2.4 4.8 8.16 16.24' }

      it 'returns the correct token' do
        lex_tokens = []

        5.times do
          lex_tokens << lexer.next
        end

        expect(lex_tokens.map(&:type)).to eq(%i[FLOAT FLOAT FLOAT FLOAT FLOAT])
        expect(lex_tokens.map(&:value)).to eq(['1.2', '2.4', '4.8', '8.16', '16.24'])
      end
    end

    context 'string' do
      let(:input) { '"hello world"' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:STRING)
        expect(token.value).to eq('hello world')
      end
    end

    context 'end of statement' do
      let(:input) { ';' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:END_OF_STATEMENT)
        expect(token.value).to eq(';')
      end
    end

    context 'function' do
      let(:input) { 'COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:FUNCTION_DEFINITION)
        expect(token.value).to eq('COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES')
      end
    end

    context 'while' do
      let(:input) { 'HORA DA PIZZA!' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:WHILE)
        expect(token.value).to eq('HORA DA PIZZA!')
      end
    end

    context 'for' do
      let(:input) { 'AGORA CURTA O MANSO!' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:FOR)
        expect(token.value).to eq('AGORA CURTA O MANSO!')
      end
    end

    context 'comma' do
      let(:input) { ',' }

      it 'returns the correct token' do
        token = lexer.next

        expect(token.type).to eq(:COMMA)
        expect(token.value).to eq(',')
      end
    end

    context 'when interpreting complex inputs' do
      context 'variable assignment' do
        let(:input) { 'custom_variable = "Peter Parker is the Spider-Man";' }

        it 'returns the correct tokens' do
          lex_tokens = []

          4.times do
            lex_tokens << lexer.next
          end

          expect(lex_tokens.map(&:type)).to eq(%i[IDENTIFIER ASSIGN STRING END_OF_STATEMENT])
          expect(lex_tokens.map(&:value)).to eq(['custom_variable', '=', 'Peter Parker is the Spider-Man', ';'])
        end
      end

      context 'print function call' do
        let(:input) { 'CLARIM DIÁRIO INFORMA("Peter parker é o homem aranha");' }

        it 'returns the correct tokens' do
          lex_tokens = []

          5.times do
            lex_tokens << lexer.next
          end

          expect(lex_tokens.map(&:type)).to eq(%i[PRINT OPEN_PARENTHESIS STRING CLOSE_PARENTHESIS END_OF_STATEMENT])
          expect(lex_tokens.map(&:value)).to eq(['CLARIM DIÁRIO INFORMA', '(', 'Peter parker é o homem aranha', ')',
                                                 ';'])
        end
      end

      context 'if statement' do
        let(:input) do
          'VAI TEIA!(true) {};'
        end

        it 'returns the correct tokens' do
          lex_tokens = []

          6.times do
            lex_tokens << lexer.next
          end

          expect(lex_tokens.map(&:type)).to eq(%i[IF OPEN_PARENTHESIS BOOLEAN CLOSE_PARENTHESIS EMPTY_BLOCK
                                                  END_OF_STATEMENT])
          expect(lex_tokens.map(&:value)).to eq(['VAI TEIA!', '(', 'true', ')', '{}', ';'])
        end
      end

      context 'if else statement' do
        let(:input) do
          'VAI TEIA!(true) {} SHAZAM! {};'
        end

        it 'returns the correct tokens' do
          lex_tokens = []

          8.times do
            lex_tokens << lexer.next
          end

          expect(lex_tokens.map(&:type)).to eq(%i[IF OPEN_PARENTHESIS BOOLEAN CLOSE_PARENTHESIS EMPTY_BLOCK ELSE
                                                  EMPTY_BLOCK END_OF_STATEMENT])
          expect(lex_tokens.map(&:value)).to eq(['VAI TEIA!', '(', 'true', ')', '{}', 'SHAZAM!', '{}', ';'])
        end
      end

      context 'if elsif else statement' do
        let(:input) do
          'VAI TEIA!(true) {} PARA O ALTO E AVANTE TEIA!(true) {} SHAZAM! {};'
        end

        it 'returns the correct tokens' do
          lex_tokens = []

          13.times do
            lex_tokens << lexer.next
          end

          expect(lex_tokens.map(&:type)).to eq(%i[
                                                 IF OPEN_PARENTHESIS BOOLEAN CLOSE_PARENTHESIS EMPTY_BLOCK
                                                 ELSIF OPEN_PARENTHESIS BOOLEAN CLOSE_PARENTHESIS EMPTY_BLOCK
                                                 ELSE EMPTY_BLOCK END_OF_STATEMENT
                                               ])
          expect(lex_tokens.map(&:value)).to eq([
                                                  'VAI TEIA!',
                                                  '(', 'true', ')', '{}', 'PARA O ALTO E AVANTE TEIA!',
                                                  '(', 'true', ')', '{}', 'SHAZAM!', '{}', ';'
                                                ])
        end
      end

      context 'function' do
        let(:input) do
          'COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES escalar(item) {};'
        end

        it 'returns the correct tokens' do
          lex_tokens = []

          7.times do
            lex_tokens << lexer.next
          end

          expect(lex_tokens.map(&:type)).to eq(%i[FUNCTION_DEFINITION IDENTIFIER OPEN_PARENTHESIS IDENTIFIER
                                                  CLOSE_PARENTHESIS EMPTY_BLOCK END_OF_STATEMENT])
          expect(lex_tokens.map(&:value)).to eq(['COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES', 'escalar', '(',
                                                 'item', ')', '{}', ';'])
        end
      end

      context 'while loop' do
        let(:input) do
          'HORA DA PIZZA!(true){};'
        end

        it 'returns the correct tokens' do
          lex_tokens = []

          6.times do
            lex_tokens << lexer.next
          end

          expect(lex_tokens.map(&:type)).to eq(%i[WHILE OPEN_PARENTHESIS BOOLEAN CLOSE_PARENTHESIS EMPTY_BLOCK
                                                  END_OF_STATEMENT])
          expect(lex_tokens.map(&:value)).to eq(['HORA DA PIZZA!', '(', 'true', ')', '{}', ';'])
        end
      end

      context 'for loop - 1st variation' do
        let(:input) do
          'AGORA CURTA O MANSO!(10) {};'
        end

        it 'returns the correct tokens' do
          lex_tokens = []

          6.times do
            lex_tokens << lexer.next
          end

          expect(lex_tokens.map(&:type)).to eq(%i[FOR OPEN_PARENTHESIS INTEGER CLOSE_PARENTHESIS EMPTY_BLOCK
                                                  END_OF_STATEMENT])
          expect(lex_tokens.map(&:value)).to eq(['AGORA CURTA O MANSO!', '(', '10',
                                                 ')', '{}', ';'])
        end
      end

      context 'for loop - 2ND variation' do
        let(:input) do
          'AGORA CURTA O MANSO!(10, i) {};'
        end

        it 'returns the correct tokens' do
          lex_tokens = []

          8.times do
            lex_tokens << lexer.next
          end

          expect(lex_tokens.map(&:type)).to eq(%i[FOR OPEN_PARENTHESIS INTEGER COMMA IDENTIFIER CLOSE_PARENTHESIS
                                                  EMPTY_BLOCK END_OF_STATEMENT])
          expect(lex_tokens.map(&:value)).to eq(['AGORA CURTA O MANSO!', '(', '10',
                                                 ',', 'i', ')', '{}', ';'])
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
# rubocop:enable Lint/NestedPercentLiteral
