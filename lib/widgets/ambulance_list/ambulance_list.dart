import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/application/ambulance_provider.dart';
import 'package:seba_admin/domain/ambulance/ambulance_model.dart';

class AmbulanceList extends HookConsumerWidget {
  const AmbulanceList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final searchController = useTextEditingController();
    final ambulanceList = ref.watch(ambulanceListProvider);
    final ValueNotifier<IList<AmbulanceModel>> list = useState(
      const IListConst([]),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff008000),
        onPressed: () {
          ref.invalidate(ambulanceListProvider);
        },
        child: Icon(Icons.refresh, color: Colors.white),
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
                  "Ambulance List",
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
        child: ambulanceList.maybeWhen(
          data: (data) {
            list.value =
                data.where((element) {
                  return element.phone.toString().toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  );
                }).toIList();
            return Padding(
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
                              return element.phone
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
                      child: Text("Total Ambulance :${data.length}"),
                    ),
                  ),
                  SizedBox(height: 30),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final ambulance = list.value[index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: Text("Ambulance Details"),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Name: ${ambulance.name}"),
                                          SizedBox(height: 10),
                                          Text("Phone: ${ambulance.phone}"),
                                          SizedBox(height: 10),
                                          Text("License: ${ambulance.license}"),
                                          SizedBox(height: 10),
                                          Text("Vehical: ${ambulance.vehicle}"),
                                          SizedBox(height: 10),
                                          Text(
                                            "Division: ${ambulance.division}",
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "District: ${ambulance.district}",
                                          ),
                                          SizedBox(height: 10),
                                          Text("Thana: ${ambulance.thana}"),
                                          SizedBox(height: 10),
                                          Text(
                                            "Local Address: ${ambulance.address}",
                                          ),
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
                                          "Name: ${ambulance.name}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Number: ${ambulance.phone}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Driving License Number: ${ambulance.license}",
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
                                            "Local Address: ${ambulance.address}",
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
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ambulance.approved
                                  ? SizedBox()
                                  : InkWell(
                                    onTap: () async {
                                      final repo = await ref.read(
                                        ambulanceRepoProvider.future,
                                      );
                                      await repo.approveAmbulance(
                                        ambulance: ambulance,
                                      );
                                      ref.invalidate(ambulanceListProvider);
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text('Approved!'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }
                                    },

                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Color(0xff008000),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                              InkWell(
                                onTap: () async {
                                  final repo = await ref.read(
                                    ambulanceRepoProvider.future,
                                  );
                                  await repo.deleteAmbulance(
                                    ambulanceId: ambulance.license,
                                  );
                                  ref.invalidate(ambulanceListProvider);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Deleted!'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    itemCount: list.value.length,
                  ),

                  SizedBox(height: 40),
                ],
              ),
            );
          },
          orElse: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
