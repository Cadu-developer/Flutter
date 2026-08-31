 1. Qual API foi escolhida?  

A API escolhida foi a **The Simpsons API**, que fornece informações sobre personagens da série *The Simpsons*.  

2. Estrutura do JSON recebido  

- A resposta da API é **uma lista de objetos JSON**, ou seja, já vem no formato de array  data`[ ]` diretamente no início da resposta, sem necessidade de acessar uma chave intermediária.  
- Cada objeto da lista representa um personagem e possui atributos como:  

{
  "id": "1",
  "firstName": "Homer",
  "lastName": "Simpson",
  "fullName": "Homer Simpson",
  "gender": "Male",
  "image": "https://link_da_imagem",
  "profession": "Nuclear Safety Inspector",
  "age": 39,
  "catchPhrase": "D'oh!"
}