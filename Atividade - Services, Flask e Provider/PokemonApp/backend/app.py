from flask import Flask, jsonify
from flask_cors import CORS
import requests

app = Flask(__name__)

CORS(app)

POKEAPI_URL = "https://pokeapi.co/api/v2/pokemon"

@app.route("/pokemons", methods=["GET"])
def listar_pokemons():

    resposta = requests.get(
        f"{POKEAPI_URL}?limit=30",
        timeout=10
    )

    if resposta.status_code != 200:
        return jsonify({
            "erro": "Erro ao consultar a PokéAPI"
        }), 502

    dados = resposta.json()

    pokemons = []

    for pokemon in dados["results"]:

        detalhes = requests.get(
            pokemon["url"],
            timeout=10
        ).json()

        pokemon_formatado = {
            "id": detalhes["id"],
            "nome": detalhes["name"],
            "imagem": detalhes["sprites"]["front_default"],
            "tipo": detalhes["types"][0]["type"]["name"]
        }

        pokemons.append(pokemon_formatado)

    return jsonify(pokemons)


def formatar_pokemon(dados):
    tipos = []

    for tipo in dados["types"]:
        tipos.append(
            tipo["type"]["name"]
        )

    habilidades = []

    for habilidade in dados["abilities"]:
        habilidades.append(
            habilidade["ability"]["name"]
        )

    return {
        "id": dados["id"],
        "nome": dados["name"],
        "imagem": dados["sprites"]["front_default"],
        "altura": dados["height"],
        "peso": dados["weight"],
        "experiencia": dados["base_experience"],
        "tipos": tipos,
        "habilidades": habilidades,
        "hp": dados["stats"][0]["base_stat"],
        "ataque": dados["stats"][1]["base_stat"],
        "defesa": dados["stats"][2]["base_stat"],
        "ataque_especial": dados["stats"][3]["base_stat"],
        "defesa_especial": dados["stats"][4]["base_stat"]
    }


# BUSCAR POKÉMON PELO ID
@app.route("/pokemons/<int:id>", methods=["GET"])
def detalhes_pokemon(id):

    resposta = requests.get(
        f"{POKEAPI_URL}/{id}",
        timeout=10
    )

    if resposta.status_code != 200:
        return jsonify({
            "erro": "Pokémon não encontrado"
        }), 404

    return jsonify(formatar_pokemon(resposta.json()))


# BUSCAR POKÉMON PELO NOME
@app.route("/pokemons/nome/<nome>", methods=["GET"])
def buscar_pokemon_nome(nome):

    nome = nome.strip().lower()

    if not nome:
        return jsonify({
            "erro": "Informe o nome de um Pokémon"
        }), 400

    resposta = requests.get(
        f"{POKEAPI_URL}/{nome}",
        timeout=10
    )

    if resposta.status_code != 200:
        return jsonify({
            "erro": "Pokémon não encontrado"
        }), 404

    return jsonify(formatar_pokemon(resposta.json()))


# POKÉMON ALEATÓRIO
@app.route("/pokemons/aleatorio", methods=["GET"])
def pokemon_aleatorio():

    import random

    id_aleatorio = random.randint(1, 1025)

    resposta = requests.get(
        f"{POKEAPI_URL}/{id_aleatorio}",
        timeout=10
    )

    if resposta.status_code != 200:
        return jsonify({
            "erro": "Erro ao buscar Pokémon aleatório"
        }), 502

    return jsonify(formatar_pokemon(resposta.json()))


if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=5001,
        debug=True
    )
