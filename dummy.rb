require './lexer.rb'
require './parser.rb'
require 'pry'

input_file = './input.spyder'
output_file = './output.rb'
input_text = File.read(input_file)

parser = Parser.new(Lexer.new)

begin
  ruby_code = parser.parse(input_text)
  File.write(output_file, "# frozen_string_literal: true\n\n#{ruby_code}")
  puts "Ruby code generated successfully in #{output_file}"
end