import '../services/database_service.dart';
import '../services/api_service.dart';
import '../models/delivery.dart';

class SynchronizationService {
  final DatabaseService _dbService = DatabaseService();
  final ApiService _apiService = ApiService();

  Future<void> syncPendingDeliveries() async {
    final deliveries = await _dbService.getDeliveries();
    for (var delivery in deliveries) {
      if (delivery.status != 'SYNCHRONIZED') {
        try {
          await _apiService.updateDeliveryStatus(delivery);
          await _dbService.insertDelivery(delivery.copyWith(status: 'SYNCHRONIZED'));
        } catch (e) {
          print('Erro ao sincronizar ${delivery.id}: $e');
        }
      }
    }
  }
}
