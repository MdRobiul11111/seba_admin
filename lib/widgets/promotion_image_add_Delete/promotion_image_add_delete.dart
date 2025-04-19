import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seba_admin/application/promotion_provider.dart';

class PromotionImageAddDelete extends HookConsumerWidget {
  const PromotionImageAddDelete({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final ValueNotifier<XFile?> selectedImage = useState(null);
    final noticeList = ref.watch(promotionListProvider);
    final isLoading = useState(false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff008000),
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 80,
          width: double.infinity,

          child: Center(
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    height: 33,
                    width: 33,
                    child: Image.asset('assets/back.png', fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "Promotion Image Add & Delete",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                // ignore: sized_box_for_whitespace
                Container(
                  height: 28,
                  width: 33,
                  child: Image.asset('assets/menu_10977681.png'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              SizedBox(height: 20),
              selectedImage.value != null
                  ? Stack(
                    children: [
                      Image.file(
                        File(selectedImage.value!.path),
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () => selectedImage.value = null,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(),
                            ),
                            child: Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  )
                  : InkWell(
                    onTap: () async {
                      final image = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        selectedImage.value = image;
                      }
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image(
                        image: AssetImage("assets/upload_8600433.png"),
                      ),
                    ),
                  ),
              SizedBox(height: 10),
              InkWell(
                onTap:
                    selectedImage.value == null
                        ? null
                        : () async {
                          isLoading.value = true;
                          final repo = await ref.read(
                            promotionRepoProvider.future,
                          );
                          await repo.uploadPromotionImage(
                            imagePath: selectedImage.value!.path,
                          );
                          selectedImage.value = null;
                          ref.invalidate(promotionListProvider);
                          isLoading.value = false;
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Promotion Uploaded!'),
                                backgroundColor: Color(0xff008000),
                              ),
                            );
                          }
                        },
                child: Container(
                  height: 50,
                  width: 190,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child:
                        isLoading.value
                            ? CircularProgressIndicator()
                            : Text(
                              "Upload Image",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              noticeList.maybeWhen(
                data:
                    (data) => ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder:
                          (context, index) => Stack(
                            children: [
                              Image.network(data[index].imgae),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: InkWell(
                                  onTap: () async {
                                    final repo = await ref.read(
                                      promotionRepoProvider.future,
                                    );
                                    await repo.deletePromotion(
                                      id: data[index].id,
                                    );
                                    ref.invalidate(promotionListProvider);
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('Promotion Deleted!'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(),
                                    ),
                                    child: Icon(Icons.close, color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 15),
                      itemCount: data.length,
                    ),
                orElse: () => Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
