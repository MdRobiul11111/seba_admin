import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/application/user_provider.dart';
import 'package:seba_admin/domain/user/user_model.dart';

class UserList extends HookConsumerWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final searchController = useTextEditingController();
    final doners = ref.watch(userListProvider);
    final ValueNotifier<IList<UserModel>> list = useState(const IListConst([]));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff008000),
        onPressed: () {
          ref.invalidate(userListProvider);
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
                  "All User List",
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
        child: doners.maybeWhen(
          data: (data) {
            list.value =
                data.where((element) {
                  return element.phoneNumber.toString().toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  );
                }).toIList();
            return Column(
              children: [
                Padding(
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
                          child: Text("Total User: ${data.length}"),
                        ),
                      ),
                      SizedBox(height: 30),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
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
                                          title: Text("Doner Details"),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Name: ${user.name}"),
                                              SizedBox(height: 10),
                                              Text(
                                                "Phone: ${user.phoneNumber}",
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Blood Group: ${user.bloodGroup}",
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Donation Complete: ${user.donationComplete}",
                                              ),
                                              SizedBox(height: 10),

                                              Text(
                                                "Division: ${user.division}",
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "District: ${user.district}",
                                              ),
                                              SizedBox(height: 10),
                                              Text("Thana: ${user.upazila}"),
                                              SizedBox(height: 10),
                                              Text(
                                                "Local Address: ${user.localAddress}",
                                              ),
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
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Spacer(),
                                            Text(
                                              user.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Blood Group: ${user.bloodGroup}",
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
                                            Text(
                                              "Age:${user.age} Years",
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
                              // Positioned(
                              //   right: 10,
                              //   top: 10,
                              //   child: InkWell(
                              //     onTap: () async {
                              //       final repo = await ref.read(
                              //         userRepoProvider.future,
                              //       );
                              //       if (context.mounted) {
                              //         await repo.deleteUser(
                              //           userId: user.uid,
                              //           context: context,
                              //         );
                              //       }
                              //       ref.invalidate(userListProvider);
                              //     },
                              //     child: Container(
                              //       height: 30,
                              //       width: 30,
                              //       decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         borderRadius: BorderRadius.circular(7),
                              //         border: Border.all(),
                              //       ),
                              //       child: Icon(
                              //         Icons.delete,
                              //         color: Colors.red,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15);
                        },
                        itemCount: list.value.length,
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            );
          },

          orElse: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
