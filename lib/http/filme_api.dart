// Importando as bibliotecas necessárias
import 'dart:convert'; // Biblioteca para lidar com codificação e decodificação de JSON.
import 'package:uniflix/model/filme.dart'; // Importando a classe Filme do seu modelo.
import 'package:http/http.dart' as http;

// Definindo a classe FilmeApi
class FilmeApi {
  // Uma string que simula a resposta da API em formato JSON.
  String urlApi = "https://raw.githubusercontent.com/CGaffoR/mock-api-filmes/main/api-movies.json";

  List<Filme> parseFilme (String response) {
    final parsed = jsonDecode(response)
        .cast<Map<String, dynamic>>();
    return parsed
        .map<Filme>((json) => Filme.fromJson(json)).toList();
  }

  Future<List<Filme>> getFilmes() async {
    // Decodificando a string JSON para um objeto Dart.
    final response = await http.get(Uri.parse(urlApi));

    if(response.statusCode == 200) {
      List<Filme> filmes = parseFilme(response.body);
      return filmes;
    }else {
      throw Exception('Falha ao obter informações da API');
    }
  }
}
