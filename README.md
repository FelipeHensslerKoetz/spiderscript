# Instruções para execução

- Clonar repositório
- Instalar Ruby na versão 3.3.0
- Intalar a gem bundler na versão 2.5.9, o comando é ```gem install bundler -v 2.5.9```
- Na raiz do projeto executar o comando ```bundle install``` para instalar as bibliotecas.
- Para criar o código na linguagem do homem-aranha edite o arquivo input.spiderscript, cheque o arquivo input.spiderscpirt.sample para ver exemplos.
- Para transpilar o código rode o comando ruby dummy.rb, caso o preocesso de transpilação dê certo será gerado um arquivo em ruby chamado output.rb, caso o processo de transpilação falhe será gerado um arquivo parser_details.txt contendo os erros de tranpilação.
- Para executar o programa ruby gerado utilize o comand ```ruby outrput.rb```
- Casoqueira rodar os testes unitários do projeto execute o comando ```rspec``` na raiz do projeto.
