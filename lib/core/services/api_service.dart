import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/delivery.dart';

class ApiService {
  final String baseUrl = 'https://seu-backend.com/api';

  Future<List<Delivery>> fetchDeliveries() async {
    final response = await http.get(Uri.parse('$baseUrl/deliveries'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Delivery(
        id: e['id'],
        status: e['status'],
        address: e['address'],
        timestamp: DateTime.parse(e['timestamp']),
        photoPath: e['photoPath'],
        latitude: e['latitude'],
        longitude: e['longitude'],
      )).toList();
    } else {
      throw Exception('Erro ao buscar entregas');
    }
  }

  Future<void> updateDeliveryStatus(Delivery delivery) async {
    final response = await http.put(
      Uri.parse('$baseUrl/deliveries/${delivery.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'status': delivery.status,
        'photoPath': delivery.photoPath,
        'latitude': delivery.latitude,
        'longitude': delivery.longitude,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar entrega');
    }
  }
}
