require 'spec_helper'
require_relative '../parser'
require_relative '../lexer.rb'
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

      it { is_expected.to eq(expected_response) }
    end

    context 'when assigning a integer to a variable' do
      let(:data) do
        'spider = 1;'
      end

      let(:expected_response) do
        "spider = 1\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when assigning a float to a variable' do
      let(:data) do
        'spider = 1.1;'
      end

      let(:expected_response) do
        "spider = 1.1\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when assigning a boolean to a variable' do
      context 'when the boolean is true' do
        let(:data) do
          'spider = true;'
        end

        let(:expected_response) do
          "spider = true\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the boolean is false' do
        let(:data) do
          'spider = false;'
        end

        let(:expected_response) do
          "spider = false\n"
        end

        it { is_expected.to eq(expected_response) }
      end
    end

    context 'when assigning a identifier to a variable' do
      let(:data) do
        'spider = another_spider;'
      end

      let(:expected_response) do
        "spider = another_spider\n"
      end

      it { is_expected.to eq(expected_response) }
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

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a subtraction' do
          let(:data) do
            'spider = 1 - 1 - 8;'
          end

          let(:expected_response) do
            "spider = 1 - 1 - 8\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a multiplication' do
          let(:data) do
            'spider = 1 * 1 * 4;'
          end

          let(:expected_response) do
            "spider = 1 * 1 * 4\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a division' do
          let(:data) do
            'spider = 1 / 1 / 42;'
          end

          let(:expected_response) do
            "spider = 1 / 1 / 42\n"
          end

          it { is_expected.to eq(expected_response) }
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

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression contains parenthesis' do
          let(:data) do
            'spider = (1 + 1) * 2;'
          end

          let(:expected_response) do
            "spider = (1 + 1) * 2\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression contains multiple parenthesis and operations' do
          let(:data) do
            'spider = (1 + 1) * (2 / 2);'
          end

          let(:expected_response) do
            "spider = (1 + 1) * (2 / 2)\n"
          end

          it { is_expected.to eq(expected_response) }
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

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a greater than or equal' do
          let(:data) do
            'spider = 1 >= 1;'
          end

          let(:expected_response) do
            "spider = 1 >= 1\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is equal' do
          let(:data) do
            'spider = 1 == 1;'
          end

          let(:expected_response) do
            "spider = 1 == 1\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is not equal' do
          let(:data) do
            'spider = 1 != 1;'
          end

          let(:expected_response) do
            "spider = 1 != 1\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is less than' do
          let(:data) do
            'spider = 1 < 1;'
          end

          let(:expected_response) do
            "spider = 1 < 1\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is less than or equal' do
          let(:data) do
            'spider = 1 <= 1;'
          end

          let(:expected_response) do
            "spider = 1 <= 1\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a logical AND' do
          let(:data) do
            'spider = 1 && 1;'
          end

          let(:expected_response) do
            "spider = 1 && 1\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a logical OR' do
          let(:data) do
            'spider = 1 || 1;'
          end

          let(:expected_response) do
            "spider = 1 || 1\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a logical NOT' do
          let(:data) do
            'spider = !true;'
          end

          let(:expected_response) do
            "spider = !true\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a mix of logical operators' do
          let(:data) do
            'spider = ((1 > 1) && (1 < 1));'
          end

          let(:expected_response) do
            "spider = ((1 > 1) && (1 < 1))\n"
          end

          it { is_expected.to eq(expected_response) }
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

        it { is_expected.to eq(expected_response) }
      end

      context 'when using the minus assign operator' do
        let(:data) do
          'spider -= 1;'
        end

        let(:expected_response) do
          "spider -= 1\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when using the multiply assign operator' do
        let(:data) do
          'spider *= 1;'
        end

        let(:expected_response) do
          "spider *= 1\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when using the divide assign operator' do
        let(:data) do
          'spider /= 1;'
        end

        let(:expected_response) do
          "spider /= 1\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when using the modulus assign operator' do
        let(:data) do
          'spider %= 1;'
        end

        let(:expected_response) do
          "spider %= 1\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when using the exponent assign operator' do
        let(:data) do
          'spider **= 1;'
        end

        let(:expected_response) do
          "spider **= 1\n"
        end

        it { is_expected.to eq(expected_response) }
      end
    end

    context 'when assigning a function call to a variable' do
      let(:data) do
        'spider = call_spider(1,2,3);'
      end

      let(:expected_response) do
        "spider = call_spider(1,2,3)\n"
      end

      it { is_expected.to eq(expected_response) }
    end
  end

  describe 'print' do
    context 'when printing a string' do
      let(:data) do
        'CLARIM DIARIO INFORMA("Peter parker eh o homem aranha");'
      end

      let(:expected_response) do
        "puts(\"Peter parker eh o homem aranha\")\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when printing a integer' do
      let(:data) do
        'CLARIM DIARIO INFORMA(1);'
      end

      let(:expected_response) do
        "puts(1)\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when printing a float' do
      let(:data) do
        'CLARIM DIARIO INFORMA(1.1);'
      end

      let(:expected_response) do
        "puts(1.1)\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when printing a boolean' do
      context 'when the boolean is true' do
        let(:data) do
          'CLARIM DIARIO INFORMA(true);'
        end

        let(:expected_response) do
          "puts(true)\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the boolean is false' do
        let(:data) do
          'CLARIM DIARIO INFORMA(false);'
        end

        let(:expected_response) do
          "puts(false)\n"
        end

        it { is_expected.to eq(expected_response) }
      end
    end

    context 'when printing a identifier' do
      let(:data) do
        'CLARIM DIARIO INFORMA(spider);'
      end

      let(:expected_response) do
        "puts(spider)\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when printing a expression' do
      context 'when printing a mathematical expression' do
        context 'when the expression is a sum' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 + 1 + 2);'
          end

          let(:expected_response) do
            "puts(1 + 1 + 2)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a subtraction' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 - 1 - 8);'
          end

          let(:expected_response) do
            "puts(1 - 1 - 8)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a multiplication' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 * 1 * 4);'
          end

          let(:expected_response) do
            "puts(1 * 1 * 4)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a division' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 / 1 / 42);'
          end

          let(:expected_response) do
            "puts(1 / 1 / 42)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a modulus' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 % 1 % 2);'
          end

          let(:expected_response) do
            "puts(1 % 1 % 2)\n"
          end
        end

        context 'when the expression is a exponent' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 ** 1 ** 8);'
          end

          let(:expected_response) do
            "puts(1 ** 1 ** 8)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression contains parenthesis' do
          let(:data) do
            'CLARIM DIARIO INFORMA((1 + 1) * 2);'
          end

          let(:expected_response) do
            "puts((1 + 1) * 2)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression contains multiple parenthesis and operations' do
          let(:data) do
            'CLARIM DIARIO INFORMA((1 + 1) * (2 / 2));'
          end

          let(:expected_response) do
            "puts((1 + 1) * (2 / 2))\n"
          end

          it { is_expected.to eq(expected_response) }
        end
      end

      context 'when printing logical expression' do
        context 'when the expression is a greater than' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 > 1);'
          end

          let(:expected_response) do
            "puts(1 > 1)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a greater than or equal' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 >= 1);'
          end

          let(:expected_response) do
            "puts(1 >= 1)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is equal' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 == 1);'
          end

          let(:expected_response) do
            "puts(1 == 1)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is not equal' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 != 1);'
          end

          let(:expected_response) do
            "puts(1 != 1)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is less than' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 < 1);'
          end

          let(:expected_response) do
            "puts(1 < 1)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is less than or equal' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 <= 1);'
          end

          let(:expected_response) do
            "puts(1 <= 1)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a logical AND' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 && 1);'
          end

          let(:expected_response) do
            "puts(1 && 1)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a logical OR' do
          let(:data) do
            'CLARIM DIARIO INFORMA(1 || 1);'
          end

          let(:expected_response) do
            "puts(1 || 1)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a logical NOT' do
          let(:data) do
            'CLARIM DIARIO INFORMA(!true);'
          end

          let(:expected_response) do
            "puts(!true)\n"
          end

          it { is_expected.to eq(expected_response) }
        end

        context 'when the expression is a mix of logical operators' do
          let(:data) do
            'CLARIM DIARIO INFORMA((1 > 1) && (1 < 1));'
          end

          let(:expected_response) do
            "puts((1 > 1) && (1 < 1))\n"
          end

          it { is_expected.to eq(expected_response) }
        end
      end
    end

    context 'when printing a function call' do
      let(:data) do
        'CLARIM DIARIO INFORMA(call_spider(1,2,3));'
      end

      let(:expected_response) do
        "puts(call_spider(1,2,3))\n"
      end

      it { is_expected.to eq(expected_response) }
    end
  end

  describe 'if statement' do
    context 'when the condition is a boolean' do
      context 'when the condition is true' do
        let(:data) do
          'VAI TEIA!(true) {};'
        end

        let(:expected_response) do
          "if(true)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is false' do
        let(:data) do
          'VAI TEIA!(false) {};'
        end

        let(:expected_response) do
          "if(false)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end
    end

    context 'when the condition is a logical expression' do
      context 'when the condition is a greater than' do
        let(:data) do
          'VAI TEIA!(1 > 1) {};'
        end

        let(:expected_response) do
          "if(1 > 1)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a greater than or equal' do
        let(:data) do
          'VAI TEIA!(1 >= 1) {};'
        end

        let(:expected_response) do
          "if(1 >= 1)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is equal' do
        let(:data) do
          'VAI TEIA!(1 == 1) {};'
        end

        let(:expected_response) do
          "if(1 == 1)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is not equal' do
        let(:data) do
          'VAI TEIA!(1 != 1) {};'
        end

        let(:expected_response) do
          "if(1 != 1)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is less than' do
        let(:data) do
          'VAI TEIA!(1 < 1) {};'
        end

        let(:expected_response) do
          "if(1 < 1)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is less than or equal' do
        let(:data) do
          'VAI TEIA!(1 <= 1) {};'
        end

        let(:expected_response) do
          "if(1 <= 1)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a logical AND' do
        let(:data) do
          'VAI TEIA!(1 && 1) {};'
        end

        let(:expected_response) do
          "if(1 && 1)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a logical OR' do
        let(:data) do
          'VAI TEIA!(1 || 1) {};'
        end

        let(:expected_response) do
          "if(1 || 1)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a logical NOT' do
        let(:data) do
          'VAI TEIA!(!true) {};'
        end

        let(:expected_response) do
          "if(!true)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a mix of logical operators' do
        let(:data) do
          'VAI TEIA!((1 > 1) && (1 < 1)) {};'
        end

        let(:expected_response) do
          "if((1 > 1) && (1 < 1))\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end
    end

    context 'when the condition is a identifier' do
      let(:data) do
        'VAI TEIA!(spider) {};'
      end

      let(:expected_response) do
        "if(spider)\nend\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when the condition is a function call' do
      let(:data) do
        'VAI TEIA!(call_spider(1,2,3)) {};'
      end

      let(:expected_response) do
        "if(call_spider(1,2,3))\nend\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when the conditional is a string' do
      let(:data) do
        'VAI TEIA!("spider") {};'
      end

      let(:expected_response) do
        "if(\"spider\")\nend\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when the conditional is a integer' do
      let(:data) do
        'VAI TEIA!(1) {};'
      end

      let(:expected_response) do
        "if(1)\nend\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when the conditional is a float' do
      let(:data) do
        'VAI TEIA!(1.1) {};'
      end

      let(:expected_response) do
        "if(1.1)\nend\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when the if block is present' do
      let(:data) do
        'VAI TEIA!(1) { peter = "parker"; CLARIM DIARIO INFORMA(1); };'
      end

      let(:expected_response) do
        "if(1)\npeter = \"parker\"\nputs(1)\nend\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when the if block is not present' do
      let(:data) do
        'VAI TEIA!(1) {};'
      end

      let(:expected_response) do
        "if(1)\nend\n"
      end

      it { is_expected.to eq(expected_response) }
    end
  end

  describe 'if/else statement' do
    context 'when the condition is a boolean' do
      context 'when the condition is true' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(true)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is false' do
        let(:data) do
          'VAI TEIA!(false) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(false)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end
    end

    context 'when the condition is a logical expression' do
      context 'when the condition is a greater than' do
        let(:data) do
          'VAI TEIA!(1 > 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 > 1)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a greater than or equal' do
        let(:data) do
          'VAI TEIA!(1 >= 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 >= 1)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is equal' do
        let(:data) do
          'VAI TEIA!(1 == 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;
          '
        end

        let(:expected_response) do
          "if(1 == 1)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is not equal' do
        let(:data) do
          'VAI TEIA!(1 != 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 != 1)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is less than' do
        let(:data) do
          'VAI TEIA!(1 < 1) {peter = "parker";} SHAZAM! {peter = "parker";};'
        end

        let(:expected_response) do
          "if(1 < 1)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is less than or equal' do
        let(:data) do
          'VAI TEIA!(1 <= 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 <= 1)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a logical AND' do
        let(:data) do
          'VAI TEIA!(1 && 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 && 1)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a logical OR' do
        let(:data) do
          'VAI TEIA!(1 || 1) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 || 1)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a logical NOT' do
        let(:data) do
          'VAI TEIA!(!true) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(!true)\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a mix of logical operators' do
        let(:data) do
          'VAI TEIA!((1 > 1) && (1 < 1)) {peter = "parker";} SHAZAM! {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if((1 > 1) && (1 < 1))\npeter = \"parker\"\nelse\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end
    end

    context 'when both blocks are empty' do
      let(:data) do
        'VAI TEIA!(true) {} SHAZAM! {};'
      end

      let(:expected_response) do
        "if(true)\nelse\nend\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when if block is not empty and else is empty' do 
      let(:data) do
        'VAI TEIA!(true) {peter = "parker";} SHAZAM! {};'
      end

      let(:expected_response) do
        "if(true)\npeter = \"parker\"\nelse\nend\n"
      end

      it { is_expected.to eq(expected_response) }
    end

    context 'when if block is empty and else is not empty' do
      let(:data) do
        'VAI TEIA!(true) {} SHAZAM! {peter = "parker";} ;'
      end

      let(:expected_response) do
        "if(true)\nelse\npeter = \"parker\"\nend\n"
      end

      it { is_expected.to eq(expected_response) }
    end
  end

  describe 'if/elsif statement' do
    context 'when there is a single if block and a single elsif block' do
      context 'when only the if block is present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {};'
        end

        let(:expected_response) do
          "if(true)\npeter = \"parker\"\nelsif(false)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when only the elsif block is present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";};'
        end

        let(:expected_response) do
          "if(false)\nelsif(true)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when both blocks are empty' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {};'
        end

        let(:expected_response) do
          "if(false)\nelsif(true)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when both blocks are present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";};'
        end

        let(:expected_response) do
          "if(true)\npeter = \"parker\"\nelsif(true)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end
    end

    context 'when there is a single if block and many elsif blocks' do
      context 'when there is only one present if block and all elsif blocks are empty' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {};'
        end

        let(:expected_response) do
          "if(true)\npeter = \"parker\"\nelsif(false)\nelsif(false)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when there is only one present if block and all elsif blocks are present' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {peter = "parker";};'
        end

        let(:expected_response) do
          "if(true)\npeter = \"parker\"\nelsif(false)\npeter = \"parker\"\nelsif(false)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when there is only one present if block and some elsif blocks are empty' do
        let(:data) do
          'VAI TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";};'
        end

        let(:expected_response) do
          "if(true)\npeter = \"parker\"\nelsif(false)\nelsif(true)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when there is only one empty if block and all elsif blocks are empty' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {};'
        end

        let(:expected_response) do
          "if(false)\nelsif(false)\nelsif(false)\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when there is only one empty if block and all elsif blocks are present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(false) {peter = "parker";};'
        end

        let(:expected_response) do
          "if(false)\nelsif(true)\npeter = \"parker\"\nelsif(false)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when there is only one empty if block and some elsif blocks are empty' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";};'
        end

        let(:expected_response) do
          "if(false)\nelsif(false)\nelsif(true)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end
    end

    context 'when the condition is a boolean' do
      context 'when the condition is true' do
        let(:data) do
          'VAI TEIA!(false) {peter = "parker";}  PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(false)\npeter = \"parker\"\nelsif(true)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is false' do
        let(:data) do
          'VAI TEIA!(false) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(false)\npeter = \"parker\"\nelsif(true)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end
    end

    context 'when the condition is a logical expression' do
      context 'when the condition is a greater than' do
        let(:data) do
          'VAI TEIA!(1 > 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 == 1) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 > 1)\npeter = \"parker\"\nelsif(1 == 1)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a greater than or equal' do
        let(:data) do
          'VAI TEIA!(1 >= 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 >= 0) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 >= 1)\npeter = \"parker\"\nelsif(1 >= 0)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is equal' do
        let(:data) do
          'VAI TEIA!(1 == 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 == 2) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 == 1)\npeter = \"parker\"\nelsif(1 == 2)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is not equal' do
        let(:data) do
          'VAI TEIA!(1 != 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 != 0) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 != 1)\npeter = \"parker\"\nelsif(1 != 0)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is less than' do
        let(:data) do
          'VAI TEIA!(1 < 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 < 1.1) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 < 1)\npeter = \"parker\"\nelsif(1 < 1.1)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is less than or equal' do
        let(:data) do
          'VAI TEIA!(1 <= 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1 <= 2) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 <= 1)\npeter = \"parker\"\nelsif(1 <= 2)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a logical AND' do
        let(:data) do
          'VAI TEIA!(1 && 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true && true) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 && 1)\npeter = \"parker\"\nelsif(true && true)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a logical OR' do
        let(:data) do
          'VAI TEIA!(1 || 1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(true || false) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1 || 1)\npeter = \"parker\"\nelsif(true || false)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a logical NOT' do
        let(:data) do
          'VAI TEIA!(!true) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(!false) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(!true)\npeter = \"parker\"\nelsif(!false)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a mix of logical operators' do
        let(:data) do
          'VAI TEIA!((1 > 1) && (1 < 1)) {peter = "parker";} PARA O ALTO E AVANTE TEIA!((1 > 1) && (1 < 1)) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if((1 > 1) && (1 < 1))\npeter = \"parker\"\nelsif((1 > 1) && (1 < 1))\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a identifier' do
        let(:data) do
          'VAI TEIA!(spider) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(spider) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(spider)\npeter = \"parker\"\nelsif(spider)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the condition is a function call' do
        let(:data) do
          'VAI TEIA!(call_spider(1,2,3)) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(call_spider(1,2,3)) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(call_spider(1,2,3))\npeter = \"parker\"\nelsif(call_spider(1,2,3))\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the conditional is a string' do
        let(:data) do
          'VAI TEIA!("spider") {peter = "parker";} PARA O ALTO E AVANTE TEIA!("spider") {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(\"spider\")\npeter = \"parker\"\nelsif(\"spider\")\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the conditional is a integer' do
        let(:data) do
          'VAI TEIA!(1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(2) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1)\npeter = \"parker\"\nelsif(2)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when the conditional is a float' do
        let(:data) do
          'VAI TEIA!(1.1) {peter = "parker";} PARA O ALTO E AVANTE TEIA!(1.2) {peter = "parker";} ;'
        end

        let(:expected_response) do
          "if(1.1)\npeter = \"parker\"\nelsif(1.2)\npeter = \"parker\"\nend\n"
        end

        it { is_expected.to eq(expected_response) }
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
          "if(true)\npeter = \"parker\"\nelsif(false)\nelse\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when only the elsif block is present' do
        let(:data) do
          'VAI TEIA!(false) {} PARA O ALTO E AVANTE TEIA!(true) {peter = "parker";} SHAZAM! {} ;'
        end

        let(:expected_response) do
          "if(false)\nelsif(true)\npeter = \"parker\"\nelse\nend\n"
        end

        it { is_expected.to eq(expected_response) }
      end

      context 'when only the else block is present' do

      end

      context 'when all blocks are present' do

      end

      context 'when all blocks are empty' do

      end 

      context 'when if block and elsif block are present' do

      end 

      context 'when if block and else block are present' do

      end 

      context 'when elsif block and else block are present' do

      end 
    end
  end
end