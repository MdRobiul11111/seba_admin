import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/application/representive_provider.dart';
import 'package:seba_admin/domain/representive/representive_code_model.dart';

class RepresentativeCodeList extends HookConsumerWidget {
  const RepresentativeCodeList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;
    final searchController = useTextEditingController();
    final nameController = useTextEditingController();
    final codeController = useTextEditingController();
    final codeList = ref.watch(representiveCodeListProvider);
    final ValueNotifier<IList<RepresentiveCodeModel>> list = useState(
      const IListConst([]),
    );
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
                  "Representive Code",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 28,
                  width: 33,
                  child: Image.asset('assets/menu_10977681.png'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: codeList.maybeWhen(
        data: (data) {
          list.value =
              data.where((element) {
                return element.code.toString().toLowerCase().contains(
                  searchController.text.toLowerCase(),
                );
              }).toIList();
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Search Your Code',
                        hintStyle: TextStyle(color: Colors.black),
                        suffixIconColor: Colors.black,
                        prefixIcon: Icon(Icons.search, size: 40),
                      ),
                      onChanged: (value) {
                        list.value =
                            data.where((element) {
                              return element.code
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase());
                            }).toIList();
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 30,
                    width: 220,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text("Total representative:  ${data.length}"),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              (context as Element).markNeedsBuild();
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: size.width * 0.6,
                          child: TextFormField(
                            controller: codeController,
                            decoration: InputDecoration(
                              hintText: "Code",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              (context as Element).markNeedsBuild();
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed:
                              nameController.text.isEmpty ||
                                      codeController.text.isEmpty
                                  ? null
                                  : () async {
                                    isLoading.value = true;
                                    final repo = await ref.read(
                                      representiveRepoProvider.future,
                                    );
                                    if (context.mounted) {
                                      await repo.addRepresentiveCode(
                                        code: RepresentiveCodeModel(
                                          name: nameController.text,
                                          code: codeController.text,
                                          isUsed: false,
                                        ),
                                        context: context,
                                      );
                                    }
                                    ref.invalidate(
                                      representiveCodeListProvider,
                                    );
                                    nameController.clear();
                                    codeController.clear();
                                    isLoading.value = false;
                                  },
                          child:
                              isLoading.value
                                  ? CircularProgressIndicator()
                                  : Text('Generate Code'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  ListView.separated(
                    itemBuilder: (context, index) {
                      final code = list.value[index];
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: size.width * 0.6,
                                  child: TextFormField(
                                    enabled: false,
                                    style: TextStyle(color: Colors.black),
                                    controller: TextEditingController(
                                      text: code.code,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: size.width * 0.6,
                                  child: TextFormField(
                                    enabled: false,
                                    controller: TextEditingController(
                                      text: code.name,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Code",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                final repo = await ref.read(
                                  representiveRepoProvider.future,
                                );
                                if (context.mounted) {
                                  await repo.deleteRepresentiveCode(
                                    code: code.code,
                                    context: context,
                                  );
                                }
                                ref.invalidate(representiveCodeListProvider);
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(),
                                ),
                                child: Icon(Icons.delete, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    itemCount: list.value.length,
                    physics: NeverScrollableScrollPhysics(),

                    shrinkWrap: true,
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
        orElse: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
