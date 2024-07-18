import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:perhutaniwisata_app/model/data_model.dart';

class DataServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  Future<List<DataModel>> getInfo() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('places').get();

      // Log the entire QuerySnapshot
      _logger
          .i('Fetched ${querySnapshot.docs.length} documents from Firestore.');

      // Log each document's data
      for (var doc in querySnapshot.docs) {
        _logger.i('Document ID: ${doc.id}, Data: ${doc.data()}');
      }

      return querySnapshot.docs.map((doc) {
        return DataModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      _logger.e('Error fetching data from Firestore: $e');
      return <DataModel>[];
    }
  }
}
