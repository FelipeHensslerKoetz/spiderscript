# frozen_string_literal: true

require 'spec_helper'
require_relative '../parser'
require_relative '../lexer'
require 'pry'

# rubocop:disable Metrics/BlockLength
RSpec.describe Parser do
  subject(:parsed_response) { Parser.new(lexer).parse(data) }

  let(:lexer) { Lexer.new }

  describe 'variable assignment' do
    context 'when assigning a string to a variable' do
      let(:data) do
        'spider_man = "Peter parker eh o homem aranha";'
      end

      let(:expected_response) do
        "spider_man = \"Peter parker eh o homem aranha\"\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when assigning a integer to a variable' do
      let(:data) do
        'spider = 1;'
      end

      let(:expected_response) do
        "spider = 1\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when assigning a float to a variable' do
      let(:data) do
        'spider = 1.1;'
      end

      let(:expected_response) do
        "spider = 1.1\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when assigning a boolean to a variable' do
      context 'when the boolean is true' do
        let(:data) do
          'spider = true;'
        end

        let(:expected_response) do
          "spider = true\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the boolean is false' do
        let(:data) do
          'spider = false;'
        end

        let(:expected_response) do
          "spider = false\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when assigning a identifier to a variable' do
      let(:data) do
        'spider = another_spider;'
      end

      let(:expected_response) do
        "spider = another_spider\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when assigning a expression to a variable' do
      context 'when assigning mathematical expression to a variable' do
        context 'when the expression is a sum' do
          let(:data) do
            'spider = 1 + 1 + 2;'
          end

          let(:expected_response) do
            "spider = 1 + 1 + 2\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a subtraction' do
          let(:data) do
            'spider = 1 - 1 - 8;'
          end

          let(:expected_response) do
            "spider = 1 - 1 - 8\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a multiplication' do
          let(:data) do
            'spider = 1 * 1 * 4;'
          end

          let(:expected_response) do
            "spider = 1 * 1 * 4\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a division' do
          let(:data) do
            'spider = 1 / 1 / 42;'
          end

          let(:expected_response) do
            "spider = 1 / 1 / 42\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a modulus' do
          let(:data) do
            'spider = 1 % 1 % 2;'
          end

          let(:expected_response) do
            "spider = 1 % 1 % 2\n"
          end
        end

        context 'when the expression is a exponent' do
          let(:data) do
            'spider = 1 ** 1 ** 8;'
          end

          let(:expected_response) do
            "spider = 1 ** 1 ** 8\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression contains parenthesis' do
          let(:data) do
            'spider = (1 + 1) * 2;'
          end

          let(:expected_response) do
            "spider = (1 + 1) * 2\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression contains multiple parenthesis and operations' do
          let(:data) do
            'spider = (1 + 1) * (2 / 2);'
          end

          let(:expected_response) do
            "spider = (1 + 1) * (2 / 2)\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end
      end

      context 'when assigning logical expression to a variable' do
        context 'when the expression is a greater than' do
          let(:data) do
            'spider = 1 > 1;'
          end

          let(:expected_response) do
            "spider = 1 > 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a greater than or equal' do
          let(:data) do
            'spider = 1 >= 1;'
          end

          let(:expected_response) do
            "spider = 1 >= 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is equal' do
          let(:data) do
            'spider = 1 == 1;'
          end

          let(:expected_response) do
            "spider = 1 == 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is not equal' do
          let(:data) do
            'spider = 1 != 1;'
          end

          let(:expected_response) do
            "spider = 1 != 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is less than' do
          let(:data) do
            'spider = 1 < 1;'
          end

          let(:expected_response) do
            "spider = 1 < 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is less than or equal' do
          let(:data) do
            'spider = 1 <= 1;'
          end

          let(:expected_response) do
            "spider = 1 <= 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a logical AND' do
          let(:data) do
            'spider = 1 && 1;'
          end

          let(:expected_response) do
            "spider = 1 && 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a logical OR' do
          let(:data) do
            'spider = 1 || 1;'
          end

          let(:expected_response) do
            "spider = 1 || 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a logical NOT' do
          let(:data) do
            'spider = !true;'
          end

          let(:expected_response) do
            "spider = !true\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a mix of logical operators' do
          let(:data) do
            'spider = ((1 > 1) && (1 < 1));'
          end

          let(:expected_response) do
            "spider = ((1 > 1) && (1 < 1))\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end
      end
    end

    context 'when using special assignment operators' do
      context 'when using the plus assign operator' do
        let(:data) do
          'spider += 1;'
        end

        let(:expected_response) do
          "spider += 1\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when using the minus assign operator' do
        let(:data) do
          'spider -= 1;'
        end

        let(:expected_response) do
          "spider -= 1\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when using the multiply assign operator' do
        let(:data) do
          'spider *= 1;'
        end

        let(:expected_response) do
          "spider *= 1\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when using the divide assign operator' do
        let(:data) do
          'spider /= 1;'
        end

        let(:expected_response) do
          "spider /= 1\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when using the modulus assign operator' do
        let(:data) do
          'spider %= 1;'
        end

        let(:expected_response) do
          "spider %= 1\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when using the exponent assign operator' do
        let(:data) do
          'spider **= 1;'
        end

        let(:expected_response) do
          "spider **= 1\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when assigning a function call to a variable' do
      let(:data) do
        'spider = call_spider(1,2,3);'
      end

      let(:expected_response) do
        "spider = call_spider(1,2,3)\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end
  end

  describe 'print' do
    context 'when printing a string' do
      let(:data) do
        'CLARIM DIÁRIO INFORMA("Peter parker eh o homem aranha");'
      end

      let(:expected_response) do
        "puts \"Peter parker eh o homem aranha\"\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when printing a integer' do
      let(:data) do
        'CLARIM DIÁRIO INFORMA(1);'
      end

      let(:expected_response) do
        "puts 1\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when printing a float' do
      let(:data) do
        'CLARIM DIÁRIO INFORMA(1.1);'
      end

      let(:expected_response) do
        "puts 1.1\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when printing a boolean' do
      context 'when the boolean is true' do
        let(:data) do
          'CLARIM DIÁRIO INFORMA(true);'
        end

        let(:expected_response) do
          "puts true\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the boolean is false' do
        let(:data) do
          'CLARIM DIÁRIO INFORMA(false);'
        end

        let(:expected_response) do
          "puts false\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when printing a identifier' do
      let(:data) do
        'CLARIM DIÁRIO INFORMA(spider);'
      end

      let(:expected_response) do
        "puts spider\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when printing a expression' do
      context 'when printing a mathematical expression' do
        context 'when the expression is a sum' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 + 1 + 2);'
          end

          let(:expected_response) do
            "puts 1 + 1 + 2\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a subtraction' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 - 1 - 8);'
          end

          let(:expected_response) do
            "puts 1 - 1 - 8\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a multiplication' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 * 1 * 4);'
          end

          let(:expected_response) do
            "puts 1 * 1 * 4\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a division' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 / 1 / 42);'
          end

          let(:expected_response) do
            "puts 1 / 1 / 42\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a modulus' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 % 1 % 2);'
          end

          let(:expected_response) do
            "puts 1 % 1 % 2\n"
          end
        end

        context 'when the expression is a exponent' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 ** 1 ** 8);'
          end

          let(:expected_response) do
            "puts 1 ** 1 ** 8\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression contains parenthesis' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA((1 + 1) * 2);'
          end

          let(:expected_response) do
            "puts (1 + 1) * 2\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression contains multiple parenthesis and operations' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA((1 + 1) * (2 / 2));'
          end

          let(:expected_response) do
            "puts (1 + 1) * (2 / 2)\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end
      end

      context 'when printing logical expression' do
        context 'when the expression is a greater than' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 > 1);'
          end

          let(:expected_response) do
            "puts 1 > 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a greater than or equal' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 >= 1);'
          end

          let(:expected_response) do
            "puts 1 >= 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is equal' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 == 1);'
          end

          let(:expected_response) do
            "puts 1 == 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is not equal' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 != 1);'
          end

          let(:expected_response) do
            "puts 1 != 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is less than' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 < 1);'
          end

          let(:expected_response) do
            "puts 1 < 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is less than or equal' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 <= 1);'
          end

          let(:expected_response) do
            "puts 1 <= 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a logical AND' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 && 1);'
          end

          let(:expected_response) do
            "puts 1 && 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a logical OR' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(1 || 1);'
          end

          let(:expected_response) do
            "puts 1 || 1\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a logical NOT' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA(!true);'
          end

          let(:expected_response) do
            "puts !true\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end

        context 'when the expression is a mix of logical operators' do
          let(:data) do
            'CLARIM DIÁRIO INFORMA((1 > 1) && (1 < 1));'
          end

          let(:expected_response) do
            "puts (1 > 1) && (1 < 1)\n"
          end

          it 'parses the input to a valid ruby output' do
            response = parsed_response

            expect(response).to eq(expected_response)
            expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
          end
        end
      end
    end

    context 'when printing a function call' do
      let(:data) do
        'CLARIM DIÁRIO INFORMA(call_spider(1,2,3));'
      end

      let(:expected_response) do
        "puts call_spider(1,2,3)\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end
  end

  describe 'if statement' do
    context 'when the condition is a boolean' do
      context 'when the condition is true' do
        let(:data) do
          'VAI TEIA!(true) {};'
        end

        let(:expected_response) do
          "if true\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is false' do
        let(:data) do
          'VAI TEIA!(false) {};'
        end

        let(:expected_response) do
          "if false\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when the condition is a logical expression' do
      context 'when the condition is a greater than' do
        let(:data) do
          'VAI TEIA!(1 > 1) {};'
        end

        let(:expected_response) do
          "if 1 > 1\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a greater than or equal' do
        let(:data) do
          'VAI TEIA!(1 >= 1) {};'
        end

        let(:expected_response) do
          "if 1 >= 1\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is equal' do
        let(:data) do
          'VAI TEIA!(1 == 1) {};'
        end

        let(:expected_response) do
          "if 1 == 1\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is not equal' do
        let(:data) do
          'VAI TEIA!(1 != 1) {};'
        end

        let(:expected_response) do
          "if 1 != 1\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is less than' do
        let(:data) do
          'VAI TEIA!(1 < 1) {};'
        end

        let(:expected_response) do
          "if 1 < 1\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is less than or equal' do
        let(:data) do
          'VAI TEIA!(1 <= 1) {};'
        end

        let(:expected_response) do
          "if 1 <= 1\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a logical AND' do
        let(:data) do
          'VAI TEIA!(1 && 1) {};'
        end

        let(:expected_response) do
          "if 1 && 1\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a logical OR' do
        let(:data) do
          'VAI TEIA!(1 || 1) {};'
        end

        let(:expected_response) do
          "if 1 || 1\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a logical NOT' do
        let(:data) do
          'VAI TEIA!(!true) {};'
        end

        let(:expected_response) do
          "if !true\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a mix of logical operators' do
        let(:data) do
          'VAI TEIA!((1 > 1) && (1 < 1)) {};'
        end

        let(:expected_response) do
          "if (1 > 1) && (1 < 1)\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when the condition is a identifier' do
      let(:data) do
        'VAI TEIA!(spider) {};'
      end

      let(:expected_response) do
        "if spider\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when the condition is a function call' do
      let(:data) do
        'VAI TEIA!(call_spider(1,2,3)) {};'
      end

      let(:expected_response) do
        "if call_spider(1,2,3)\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when the conditional is a string' do
      let(:data) do
        'VAI TEIA!("spider") {};'
      end

      let(:expected_response) do
        "if \"spider\"\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when the conditional is a integer' do
      let(:data) do
        'VAI TEIA!(1) {};'
      end

      let(:expected_response) do
        "if 1\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when the conditional is a float' do
      let(:data) do
        'VAI TEIA!(1.1) {};'
      end

      let(:expected_response) do
        "if 1.1\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when the if block is present' do
      let(:data) do
        'VAI TEIA!(1) { peter = "parker"; CLARIM DIÁRIO INFORMA(1); };'
      end

      let(:expected_response) do
        "if 1\n\s\speter = \"parker\"\n\s\sputs 1\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when the if block is not present' do
      let(:data) do
        'VAI TEIA!(1) {};'
      end

      let(:expected_response) do
        "if 1\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end
  end

  describe 'if/else statement' do
    context 'when the condition is a boolean' do
      context 'when the condition is true' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is false' do
        let(:data) do
          'VAI TEIA!(false) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if false\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when the condition is a logical expression' do
      context 'when the condition is a greater than' do
        let(:data) do
          'VAI TEIA!(1 > 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 > 1\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a greater than or equal' do
        let(:data) do
          'VAI TEIA!(1 >= 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 >= 1\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is equal' do
        let(:data) do
          'VAI TEIA!(1 == 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;
          '
        end

        let(:expected_response) do
          "if 1 == 1\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is not equal' do
        let(:data) do
          'VAI TEIA!(1 != 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 != 1\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is less than' do
        let(:data) do
          'VAI TEIA!(1 < 1) {peter = "parker";} SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if 1 < 1\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is less than or equal' do
        let(:data) do
          'VAI TEIA!(1 <= 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 <= 1\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a logical AND' do
        let(:data) do
          'VAI TEIA!(1 && 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 && 1\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a logical OR' do
        let(:data) do
          'VAI TEIA!(1 || 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 || 1\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a logical NOT' do
        let(:data) do
          'VAI TEIA!(!true) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if !true\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a mix of logical operators' do
        let(:data) do
          'VAI TEIA!((1 > 1) && (1 < 1)) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if (1 > 1) && (1 < 1)\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when both blocks are empty' do
      let(:data) do
        'VAI TEIA!(true) {} SHAZAM! {};'
      end

      let(:expected_response) do
        "if true\nelse\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when if block is not empty and else is empty' do
      let(:data) do
        'VAI TEIA!(true) {peter = "parker";} SHAZAM! {};'
      end

      let(:expected_response) do
        "if true\n\s\speter = \"parker\"\nelse\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when if block is empty and else is not empty' do
      let(:data) do
        'VAI TEIA!(true) {} SHAZAM! {peter = "parker";} ;'
      end

      let(:expected_response) do
        "if true\nelse\n\s\speter = \"parker\"\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end
  end

  describe 'if/elsif statement' do
    context 'when there is a single if block and a single elsif block' do
      context 'when only the if block is present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when only the elsif block is present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";};'
        end

        let(:expected_response) do
          "if false\nelsif true\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when both blocks are empty' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {};'
        end

        let(:expected_response) do
          "if false\nelsif true\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when both blocks are present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif true\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when there is a single if block and many elsif blocks' do
      context 'when there is only one present if block and all elsif blocks are empty' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\nelsif false\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when there is only one present if block and all elsif blocks are present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {peter = "parker";};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\n\s\speter = \"parker\"\nelsif false\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when there is only one present if block and some elsif blocks are empty' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\nelsif true\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when there is only one empty if block and all elsif blocks are empty' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {};'
        end

        let(:expected_response) do
          "if false\nelsif false\nelsif false\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when there is only one empty if block and all elsif blocks are present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {peter = "parker";};'
        end

        let(:expected_response) do
          "if false\nelsif true\n\s\speter = \"parker\"\nelsif false\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when there is only one empty if block and some elsif blocks are empty' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";};'
        end

        let(:expected_response) do
          "if false\nelsif false\nelsif true\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when the condition is a boolean' do
      context 'when the condition is true' do
        let(:data) do
          'VAI TEIA!(false) {peter = "parker";}  PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if false\n\s\speter = \"parker\"\nelsif true\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is false' do
        let(:data) do
          'VAI TEIA!(false) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if false\n\s\speter = \"parker\"\nelsif true\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when the condition is a logical expression' do
      context 'when the condition is a greater than' do
        let(:data) do
          'VAI TEIA!(1 > 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 == 1) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 > 1\n\s\speter = \"parker\"\nelsif 1 == 1\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a greater than or equal' do
        let(:data) do
          'VAI TEIA!(1 >= 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 >= 0) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 >= 1\n\s\speter = \"parker\"\nelsif 1 >= 0\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is equal' do
        let(:data) do
          'VAI TEIA!(1 == 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 == 2) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 == 1\n\s\speter = \"parker\"\nelsif 1 == 2\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is not equal' do
        let(:data) do
          'VAI TEIA!(1 != 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 != 0) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 != 1\n\s\speter = \"parker\"\nelsif 1 != 0\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is less than' do
        let(:data) do
          'VAI TEIA!(1 < 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 < 1.1) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 < 1\n\s\speter = \"parker\"\nelsif 1 < 1.1\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is less than or equal' do
        let(:data) do
          'VAI TEIA!(1 <= 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 <= 2) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 <= 1\n\s\speter = \"parker\"\nelsif 1 <= 2\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a logical AND' do
        let(:data) do
          'VAI TEIA!(1 && 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true && true) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 && 1\n\s\speter = \"parker\"\nelsif true && true\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a logical OR' do
        let(:data) do
          'VAI TEIA!(1 || 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true || false) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1 || 1\n\s\speter = \"parker\"\nelsif true || false\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a logical NOT' do
        let(:data) do
          'VAI TEIA!(!true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(!false) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if !true\n\s\speter = \"parker\"\nelsif !false\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a mix of logical operators' do
        let(:data) do
          'VAI TEIA!((1 > 1) && (1 < 1)) {peter = "parker";} PARA O ALTO E AVANTE TEIA!((1 > 1) && (1 < 1)) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if (1 > 1) && (1 < 1)\n\s\speter = \"parker\"\nelsif (1 > 1) && (1 < 1)\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a identifier' do
        let(:data) do
          'VAI TEIA!(spider) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(spider) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if spider\n\s\speter = \"parker\"\nelsif spider\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the condition is a function call' do
        let(:data) do
          'VAI TEIA!(call_spider(1,2,3)) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(call_spider(1,2,3)) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if call_spider(1,2,3)\n\s\speter = \"parker\"\nelsif call_spider(1,2,3)\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the conditional is a string' do
        let(:data) do
          'VAI TEIA!("spider") {peter = "parker";} PARA O ALTO E AVANTE TEIA!("spider") {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if \"spider\"\n\s\speter = \"parker\"\nelsif \"spider\"\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the conditional is a integer' do
        let(:data) do
          'VAI TEIA!(1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(2) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1\n\s\speter = \"parker\"\nelsif 2\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the conditional is a float' do
        let(:data) do
          'VAI TEIA!(1.1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1.2) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if 1.1\n\s\speter = \"parker\"\nelsif 1.2\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end
  end

  describe 'if/elsif/else statement' do
    context 'when there is a single if block, a single elsif block and a single else block' do
      context 'when only the if block is present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {} SHAZAM! {} ;'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\nelse\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when only the elsif block is present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} SHAZAM! {} ;'
        end

        let(:expected_response) do
          "if false\nelsif true\n\s\speter = \"parker\"\nelse\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when only the else block is present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if false\nelsif false\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when all blocks are present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {peter = "parker";} SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when all blocks are empty' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} SHAZAM! {};'
        end

        let(:expected_response) do
          "if false\nelsif false\nelse\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when if block and elsif block are present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {peter = "parker";} SHAZAM! {};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\n\s\speter = \"parker\"\nelse\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when if block and else block are present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {} SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when elsif block and else block are present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if false\nelsif true\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when there is a single if block, many elsif blocks and a single else block' do
      context 'if present, all eslifs blocks empty and else empty' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} SHAZAM! {};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\nelsif false\nelse\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if present, some elsif blocks empty and else empty' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";}
          SHAZAM! {};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\nelsif true\n\s\speter = \"parker\"\nelse\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if present, all elsif blocks present and else empty' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";}
          SHAZAM! {};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\n\s\speter = \"parker\"\nelsif true\n\s\speter = \"parker\"\nelse\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if present, all elsif blocks empty and else present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\nelsif false\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if present, some elsif blocks empty and else present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";}
          SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\nelsif true\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if present, all elsif blocks present and else present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";}
          SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if true\n\s\speter = \"parker\"\nelsif false\n\s\speter = \"parker\"\nelsif true\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if empty, all elsif blocks empty and else empty' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} SHAZAM! {};'
        end

        let(:expected_response) do
          "if false\nelsif false\nelsif false\nelse\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if empty, some elsif blocks empty and else empty' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";}
          SHAZAM! {};'
        end

        let(:expected_response) do
          "if false\nelsif false\nelsif true\n\s\speter = \"parker\"\nelse\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if empty, all elsif blocks present and else empty' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";}
          SHAZAM! {};'
        end

        let(:expected_response) do
          "if false\nelsif true\n\s\speter = \"parker\"\nelsif true\n\s\speter = \"parker\"\nelse\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if empty, all elsif blocks empty and else present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {}  PARA O ALTO E AVANTE TEIA!(false) {} SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if false\nelsif false\nelsif false\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if empty, some elsif blocks empty and else present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";}
          SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if false\nelsif false\nelsif true\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'if empty, all elsif blocks present and else present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";}
          SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if false\nelsif true\n\s\speter = \"parker\"\nelsif true\n\s\speter = \"parker\"\nelse\n\s\speter = \"parker\"\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end
  end

  describe 'function definition statement' do
    context 'when function has no parameters and an empty block' do
      let(:data) do
        'COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES escalar(){};'
      end

      let(:expected_response) do
        "def escalar\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when function has no parameters and a non-empty block' do
      let(:data) do
        'COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES escalar(){peter = "parker";};'
      end

      let(:expected_response) do
        "def escalar\n\s\speter = \"parker\"\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when function has one parameter and an empty block' do
      let(:data) do
        'COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES escalar(spider){};'
      end

      let(:expected_response) do
        "def escalar(spider)\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when function has one parameter and a non-empty block' do
      let(:data) do
        'COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES escalar(spider){peter = "parker";};'
      end

      let(:expected_response) do
        "def escalar(spider)\n\s\speter = \"parker\"\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when function has many parameters and an empty block' do
      let(:data) do
        'COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES escalar(spider,man){};'
      end

      let(:expected_response) do
        "def escalar(spider,man)\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when function has many parameters and a non-empty block' do
      let(:data) do
        'COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES escalar(spider,man){peter = "parker";};'
      end

      let(:expected_response) do
        "def escalar(spider,man)\n\s\speter = \"parker\"\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when using a return inside the function definition' do
      let(:data) do
        'COM GRANDES PODERES VÊM GRANDES RESPONSABILIDADES escalar(spider,man) { SEGURA O TROCO!("Shazam!"); };'
      end

      let(:expected_response) do
        "def escalar(spider,man)\n\s\sreturn \"Shazam!\"\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end
  end

  describe 'while block statement' do
    context 'when the block condition is an expression' do
      let(:data) do
        'HORA DA PIZZA!(1 > 1 && 20 >= 19){};'
      end

      let(:expected_response) do
        "while 1 > 1 && 20 >= 19\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when the block is empty' do
      let(:data) do
        'HORA DA PIZZA!(true){};'
      end

      let(:expected_response) do
        "while true\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end

    context 'when the block is not empty' do
      let(:data) do
        'HORA DA PIZZA!(true){peter = "parker"; OLHA O DUENDE JÚNIOR, VAI CHORAR?;};'
      end

      let(:expected_response) do
        "while true\n\s\speter = \"parker\"\n\s\sbreak\nend\n"
      end

      it 'parses the input to a valid ruby output' do
        response = parsed_response

        expect(response).to eq(expected_response)
        expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
      end
    end
  end

  describe 'for block statement' do
    context 'when the for has only a integer as first argument' do
      context 'when the for block is empty' do
        let(:data) do
          'AGORA CURTA O MANSO!(10){};'
        end

        let(:expected_response) do
          "10.times do\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the for block is not empty' do
        let(:data) do
          'AGORA CURTA O MANSO!(10){E QUEM DISSE QUE ISSO É PROBLEMA MEU?;};'
        end

        let(:expected_response) do
          "10.times do\n\s\snext\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end

    context 'when the for has an integer as first argument and a identifier as second argument' do
      context 'when the for block is empty' do
        let(:data) do
          'AGORA CURTA O MANSO!(10, spider){};'
        end

        let(:expected_response) do
          "10.times do |spider|\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end

      context 'when the for block is not empty' do
        let(:data) do
          'AGORA CURTA O MANSO!(10, spider){E QUEM DISSE QUE ISSO É PROBLEMA MEU?;};'
        end

        let(:expected_response) do
          "10.times do |spider|\n\s\snext\nend\n"
        end

        it 'parses the input to a valid ruby output' do
          response = parsed_response

          expect(response).to eq(expected_response)
          expect { RubyVM::InstructionSequence.compile(response) }.not_to raise_error
        end
      end
    end
  end
end
