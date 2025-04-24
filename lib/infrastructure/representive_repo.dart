import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:seba_admin/domain/representive/i_representive_repo.dart';
import 'package:seba_admin/domain/representive/representive_code_model.dart';
import 'package:seba_admin/domain/representive/representive_model.dart';

class RepresentiveRepo extends IRepresentiveRepo {
  final codeCollection = FirebaseFirestore.instance.collection(
    'representive_code',
  );

  final representiveCollection = FirebaseFirestore.instance.collection(
    'Registration',
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

  @override
  Future<void> deleteRepresentive({
    required String id,
    required BuildContext context,
  }) async {
    await representiveCollection.doc(id).delete();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Representive Deleted!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Future<IList<RepresentiveModel>> getRepresentiveList() async {
    try {
      final QuerySnapshot snapshot = await representiveCollection.get();
      Logger().d(snapshot.docs.length);
      final data =
          snapshot.docs
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final id = doc.id;
                final rep = RepresentiveModel.fromMap(data);
                return rep.copyWith(id: id);
              })
              .toIList()
              .reversed;

      return data;
    } catch (e) {
      Logger().e(e.toString());
      return IList<RepresentiveModel>([]);
    }
  }
}
