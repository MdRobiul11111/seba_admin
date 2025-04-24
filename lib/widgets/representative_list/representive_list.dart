import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/application/representive_provider.dart';
import 'package:seba_admin/domain/representive/representive_model.dart';
import 'package:seba_admin/widgets/representative_list/representative_code_list.dart';

class RepresentiveList extends HookConsumerWidget {
  const RepresentiveList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final searchController = useTextEditingController();
    final representiveList = ref.watch(representiveListProvider);
    final ValueNotifier<IList<RepresentiveModel>> list = useState(
      const IListConst([]),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff008000),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RepresentativeCodeList()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
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
                  "Representive List",
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
      body: representiveList.maybeWhen(
        data: (data) {
          list.value =
              data.where((element) {
                return element.phoneNumber.toString().toLowerCase().contains(
                  searchController.text.toLowerCase(),
                );
              }).toIList();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
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
                        hintText: 'Search Your Phone Number',
                        hintStyle: TextStyle(color: Colors.black),
                        suffixIconColor: Colors.black,
                        prefixIcon: Icon(Icons.search, size: 40),
                      ),
                      onChanged: (value) {
                        list.value =
                            data.where((element) {
                              return element.phoneNumber
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
                  ListView.separated(
                    itemBuilder: (context, index) {
                      final user = list.value[index];
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: Text("patient Details"),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Name: ${user.name}"),
                                          SizedBox(height: 10),
                                          Text("Phone: ${user.phoneNumber}"),
                                          SizedBox(height: 10),
                                          Text("Father: ${user.fatherName}"),
                                          SizedBox(height: 10),
                                          Text("Mother: ${user.motherName}"),
                                          SizedBox(height: 10),
                                          Text(
                                            "NID: ${user.nidOrBirthCertificate}",
                                          ),
                                          SizedBox(height: 10),
                                          Text("Division: ${user.division}"),
                                          SizedBox(height: 10),
                                          Text("District: ${user.district}"),
                                          SizedBox(height: 10),
                                          Text("Thana: ${user.thana}"),
                                          SizedBox(height: 10),
                                          Text(
                                            "Local Address: ${user.localAddress}",
                                          ),
                                          SizedBox(height: 10),
                                          Text("Postal Code: ${user.post}"),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.pop(context),
                                          child: Text("Close"),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name: ${user.name}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Nid/Birth Cirteficate: ${user.nidOrBirthCertificate}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Number: ${user.phoneNumber}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                .8,
                                          ),
                                          child: Text(
                                            "Local Address: ${user.localAddress}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: InkWell(
                              onTap: () async {
                                final repo = await ref.read(
                                  representiveRepoProvider.future,
                                );
                                if (context.mounted) {
                                  await repo.deleteRepresentive(
                                    context: context,
                                    id: user.id,
                                  );
                                }
                                ref.invalidate(representiveListProvider);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                child: Icon(Icons.delete, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: list.value.length,
                  ),

                  SizedBox(height: 40),
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
