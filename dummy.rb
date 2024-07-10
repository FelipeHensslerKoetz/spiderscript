require './lexer.rb'
require './parser.rb'

@input_file = './input.spiderscript'
@output_file = './output.rb'
@input_text = File.read(@input_file).gsub(/\n/, '').gsub(/(\s\s+)/, '')
@parser = Parser.new(Lexer.new)
@ruby_code = nil

File.open('parser_details.txt', 'w') do |file|
  $stdout = file
  @ruby_code = @parser.parse(@input_text, true)
  $stdout = STDOUT
  file.close
end

@parser_details = File.read('parser_details.txt')

if @parser_details.match?(/(error|Syntax error|Fail)/)
  puts 'Syntax error(s) were found in the input file. Please check parser_details.txt for more information.'
  puts 'No Ruby code was generated.'
else
  puts 'Generating Ruby code...'
  File.write(@output_file, @ruby_code)
  puts 'Ruby code generated successfully! Check output.rb for the generated code.'
end
