import 'package:dio/dio.dart';

class TMDBService {
  late Dio _dio;
  final String _apiKey = 'd17f4fce1773d642f23563b737b4f7b3';

  TMDBService() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMTdmNGZjZTE3NzNkNjQyZjIzNTYzYjczN2I0ZjdiMyIsInN1YiI6IjY1NmNjNGE5NTY4NDYzMDBlZTEzMDYwZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uDNpGx2X3rQQUgunBMl66uPj6c-mL80-vqp07T38J1A',
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    final fullQueryParams = {
      ...?queryParams,
      'd17f4fce1773d642f23563b737b4f7b3': _apiKey,
    };
    return _dio.get(path, queryParameters: fullQueryParams);
  }


  Dio get dio => _dio;
}

