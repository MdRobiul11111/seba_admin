import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:seba_admin/domain/representive/i_representive_repo.dart';
import 'package:seba_admin/domain/representive/representive_code_model.dart';

class RepresentiveRepo extends IRepresentiveRepo {
  final codeCollection = FirebaseFirestore.instance.collection(
    'representive_code',
  );

  @override
  Future<void> addRepresentiveCode({
    required RepresentiveCodeModel code,
    required BuildContext context,
  }) async {
    final docRef = codeCollection.doc(code.code);
    final data = await docRef.get();
    if (data.exists) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Code Already Exists!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      await docRef.set(code.toMap());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Code Created!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Future<IList<RepresentiveCodeModel>> getRepresentiveCodeList() async {
    try {
      final QuerySnapshot snapshot = await codeCollection.get();
      final data =
          snapshot.docs
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return RepresentiveCodeModel.fromMap(data);
              })
              .toIList()
              .reversed;

      return data;
    } catch (e) {
      Logger().e(e.toString());
      return IList<RepresentiveCodeModel>([]);
    }
  }

  @override
  Future<void> deleteRepresentiveCode({
    required String code,
    required BuildContext context,
  }) async {
    await codeCollection.doc(code).delete();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Code Deleted!'), backgroundColor: Colors.red),
      );
    }
  }
}
