import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> acceptedDeliveries = [];
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

    await _loadAcceptedDeliveries();
  }

  Future<void> _loadAcceptedDeliveries() async {
    final data = await database.query(
      'deliveries',
      where: 'status = ?',
      whereArgs: ['aceita'],
    );
    setState(() => acceptedDeliveries = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Histórico de Entregas')),
      body: acceptedDeliveries.isEmpty
          ? Center(child: Text('Nenhuma entrega aceita ainda.'))
          : ListView.builder(
              itemCount: acceptedDeliveries.length,
              itemBuilder: (context, index) {
                final delivery = acceptedDeliveries[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(Icons.history)),
                    title: Text('Entrega #${delivery['id']}'),
                    subtitle: Text(delivery['address']),
                  ),
                );
              },
            ),
    );
  }
}
