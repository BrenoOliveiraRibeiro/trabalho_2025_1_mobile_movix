import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;


class DeliveriesPage extends StatefulWidget {
  @override
  _DeliveriesPageState createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends State<DeliveriesPage> {
  List<Map<String, dynamic>> deliveries = [];
  late Database database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'deliveries.db');


    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE deliveries(id TEXT PRIMARY KEY, address TEXT, status TEXT)',
        );
      },
    );

    await _loadDeliveries();
  }

  Future<void> _loadDeliveries() async {
    final data = await database.query('deliveries');

    if (data.isEmpty) {
      await _insertSampleData();
      final updatedData = await database.query('deliveries');
      setState(() => deliveries = updatedData);
    } else {
      setState(() => deliveries = data);
    }
  }

  Future<void> _insertSampleData() async {
    await database.insert('deliveries', {
      'id': '123',
      'address': 'Rua Exemplo 100',
      'status': 'pendente',
    });
    await database.insert('deliveries', {
      'id': '124',
      'address': 'Av. Principal 200',
      'status': 'pendente',
    });
  }

  Future<void> _acceptDelivery(Map<String, dynamic> delivery) async {
    await database.update(
      'deliveries',
      {'status': 'aceita'},
      where: 'id = ?',
      whereArgs: [delivery['id']],
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Entrega ${delivery['id']} aceita!')),
    );
    await _loadDeliveries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entregas Disponíveis')),
      body: ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          final delivery = deliveries[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.local_shipping)),
              title: Text('Entrega #${delivery['id']}'),
              subtitle: Text(delivery['address']),
              trailing: ElevatedButton(
                onPressed: delivery['status'] == 'pendente'
                    ? () => _acceptDelivery(delivery)
                    : null,
                child: Text(delivery['status'] == 'pendente' ? 'Aceitar' : 'Aceita'),
              ),
            ),
          );
        },
      ),
    );
  }
}
