A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

Modelagem (lib/animal.dart):
Crie uma classe abstrata Pet com: int id, String nome e o atributo privado double _peso.
Crie um Setter para _peso que não aceite valores negativos ou zero.
Crie um método chamado engordar(double ganho) que soma o valor ao peso atual (use o setter para validar).
Crie a classe filha Cachorro com o atributo String raca.
Implemente o método toJson().
Lógica Principal (bin/main.dart):
Leitura: Carregue os dados do arquivo petshop.json.
Atualização de Peso: Peça o ID de um pet já cadastrado e um valor de ganho de peso. Localize o objeto na lista, chame o método engordar() e salve o arquivo.
Remoção Condicional: Crie uma opção para remover um pet pelo ID.
Relatório Simples: Exiba a média de peso de todos os cachorros cadastrados antes de fechar o programa.

