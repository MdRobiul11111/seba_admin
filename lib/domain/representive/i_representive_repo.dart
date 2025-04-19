import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:seba_admin/domain/representive/representive_code_model.dart';
import 'package:seba_admin/domain/representive/representive_model.dart';

abstract class IRepresentiveRepo {
  Future<void> addRepresentiveCode({
    required RepresentiveCodeModel code,
    required BuildContext context,
  });
  Future<IList<RepresentiveCodeModel>> getRepresentiveCodeList();
  Future<void> deleteRepresentiveCode({
    required String code,
    required BuildContext context,
  });

  Future<IList<RepresentiveModel>> getRepresentiveList();
  Future<void> deleteRepresentive({
    required String id,
    required BuildContext context,
  });
}
