import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seba_admin/application/hotline_provider.dart';

class HotLineLinkAddDelete extends HookConsumerWidget {
  const HotLineLinkAddDelete({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final hotlines = ref.watch(hotlineListProvider);
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
                  "Hot Line Link Add & Delete",
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
      body: hotlines.when(
        data: (hotline) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  children: [
                    SizedBox(height: 70),

                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .8,
                              ),
                              child: Text(
                                "Web Site link: ${hotline.websiteLink.isNotEmpty ? hotline.websiteLink : ".............................................."}",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => HookBuilder(
                                        builder: (context) {
                                          final TextEditingController
                                          controller = useTextEditingController(
                                            text: hotline.websiteLink,
                                          );
                                          final isLoading = useState(false);
                                          return AlertDialog(
                                            title: Text("Edit"),
                                            content: SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  .8,
                                              child: TextFormField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                  hintText: "Enter new link",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                              ),
                                            ),
                                            actions: [
                                              InkWell(
                                                onTap:
                                                    controller.text.isEmpty
                                                        ? null
                                                        : () async {
                                                          isLoading.value =
                                                              true;
                                                          final repo = await ref
                                                              .read(
                                                                hotlineRepoProvider
                                                                    .future,
                                                              );
                                                          final data = hotline
                                                              .copyWith(
                                                                websiteLink:
                                                                    controller
                                                                        .text,
                                                              );
                                                          await repo
                                                              .updateHotline(
                                                                hotline: data,
                                                              );

                                                          ref.invalidate(
                                                            hotlineListProvider,
                                                          );
                                                          isLoading.value =
                                                              false;
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                          }
                                                          if (context.mounted) {
                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Notice Uploaded!',
                                                                ),
                                                                backgroundColor:
                                                                    Color(
                                                                      0xff008000,
                                                                    ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                child: Container(
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          controller
                                                                  .text
                                                                  .isEmpty
                                                              ? Colors.grey
                                                              : Colors.green,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child:
                                                        isLoading.value
                                                            ? CircularProgressIndicator()
                                                            : Text(
                                                              "Save",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                );
                              },
                              child: Image.asset(
                                'assets/edit.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .8,
                              ),
                              child: Text(
                                "Facebook link: ${hotline.facebookLink.isNotEmpty ? hotline.facebookLink : ".............................................."}",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => HookBuilder(
                                        builder: (context) {
                                          final TextEditingController
                                          controller = useTextEditingController(
                                            text: hotline.facebookLink,
                                          );
                                          final isLoading = useState(false);
                                          return AlertDialog(
                                            title: Text("Edit"),
                                            content: SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  .8,
                                              child: TextFormField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                  hintText: "Enter new link",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                              ),
                                            ),
                                            actions: [
                                              InkWell(
                                                onTap:
                                                    controller.text.isEmpty
                                                        ? null
                                                        : () async {
                                                          isLoading.value =
                                                              true;
                                                          final repo = await ref
                                                              .read(
                                                                hotlineRepoProvider
                                                                    .future,
                                                              );
                                                          final data = hotline
                                                              .copyWith(
                                                                facebookLink:
                                                                    controller
                                                                        .text,
                                                              );
                                                          await repo
                                                              .updateHotline(
                                                                hotline: data,
                                                              );

                                                          ref.invalidate(
                                                            hotlineListProvider,
                                                          );
                                                          isLoading.value =
                                                              false;
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                          }
                                                          if (context.mounted) {
                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Hotlink updated!',
                                                                ),
                                                                backgroundColor:
                                                                    Color(
                                                                      0xff008000,
                                                                    ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                child: Container(
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          controller
                                                                  .text
                                                                  .isEmpty
                                                              ? Colors.grey
                                                              : Colors.green,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child:
                                                        isLoading.value
                                                            ? CircularProgressIndicator()
                                                            : Text(
                                                              "Save",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                );
                              },
                              child: Image.asset(
                                'assets/edit.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .8,
                              ),
                              child: Text(
                                "Youtube link: ${hotline.youtubeLink.isNotEmpty ? hotline.youtubeLink : ".............................................."}",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => HookBuilder(
                                        builder: (context) {
                                          final TextEditingController
                                          controller = useTextEditingController(
                                            text: hotline.youtubeLink,
                                          );
                                          final isLoading = useState(false);
                                          return AlertDialog(
                                            title: Text("Edit"),
                                            content: SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  .8,
                                              child: TextFormField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                  hintText: "Enter new link",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                              ),
                                            ),
                                            actions: [
                                              InkWell(
                                                onTap:
                                                    controller.text.isEmpty
                                                        ? null
                                                        : () async {
                                                          isLoading.value =
                                                              true;
                                                          final repo = await ref
                                                              .read(
                                                                hotlineRepoProvider
                                                                    .future,
                                                              );
                                                          final data = hotline
                                                              .copyWith(
                                                                youtubeLink:
                                                                    controller
                                                                        .text,
                                                              );
                                                          await repo
                                                              .updateHotline(
                                                                hotline: data,
                                                              );

                                                          ref.invalidate(
                                                            hotlineListProvider,
                                                          );
                                                          isLoading.value =
                                                              false;
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                          }
                                                          if (context.mounted) {
                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Hotlink updated!',
                                                                ),
                                                                backgroundColor:
                                                                    Color(
                                                                      0xff008000,
                                                                    ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                child: Container(
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          controller
                                                                  .text
                                                                  .isEmpty
                                                              ? Colors.grey
                                                              : Colors.green,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child:
                                                        isLoading.value
                                                            ? CircularProgressIndicator()
                                                            : Text(
                                                              "Save",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                );
                              },
                              child: Image.asset(
                                'assets/edit.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .8,
                              ),
                              child: Text(
                                "Instagram link: ${hotline.instagramLink.isNotEmpty ? hotline.instagramLink : ".............................................."}",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => HookBuilder(
                                        builder: (context) {
                                          final TextEditingController
                                          controller = useTextEditingController(
                                            text: hotline.instagramLink,
                                          );
                                          final isLoading = useState(false);
                                          return AlertDialog(
                                            title: Text("Edit"),
                                            content: SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  .8,
                                              child: TextFormField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                  hintText: "Enter new link",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                              ),
                                            ),
                                            actions: [
                                              InkWell(
                                                onTap:
                                                    controller.text.isEmpty
                                                        ? null
                                                        : () async {
                                                          isLoading.value =
                                                              true;
                                                          final repo = await ref
                                                              .read(
                                                                hotlineRepoProvider
                                                                    .future,
                                                              );
                                                          final data = hotline
                                                              .copyWith(
                                                                instagramLink:
                                                                    controller
                                                                        .text,
                                                              );
                                                          await repo
                                                              .updateHotline(
                                                                hotline: data,
                                                              );

                                                          ref.invalidate(
                                                            hotlineListProvider,
                                                          );
                                                          isLoading.value =
                                                              false;
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                          }
                                                          if (context.mounted) {
                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Hotlink updated!',
                                                                ),
                                                                backgroundColor:
                                                                    Color(
                                                                      0xff008000,
                                                                    ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                child: Container(
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          controller
                                                                  .text
                                                                  .isEmpty
                                                              ? Colors.grey
                                                              : Colors.green,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child:
                                                        isLoading.value
                                                            ? CircularProgressIndicator()
                                                            : Text(
                                                              "Save",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                );
                              },
                              child: Image.asset(
                                'assets/edit.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .8,
                              ),
                              child: Text(
                                "Twitter link: ${hotline.twitterLink.isNotEmpty ? hotline.twitterLink : ".............................................."}",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => HookBuilder(
                                        builder: (context) {
                                          final TextEditingController
                                          controller = useTextEditingController(
                                            text: hotline.twitterLink,
                                          );
                                          final isLoading = useState(false);
                                          return AlertDialog(
                                            title: Text("Edit"),
                                            content: SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  .8,
                                              child: TextFormField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                  hintText: "Enter new link",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                              ),
                                            ),
                                            actions: [
                                              InkWell(
                                                onTap:
                                                    controller.text.isEmpty
                                                        ? null
                                                        : () async {
                                                          isLoading.value =
                                                              true;
                                                          final repo = await ref
                                                              .read(
                                                                hotlineRepoProvider
                                                                    .future,
                                                              );
                                                          final data = hotline
                                                              .copyWith(
                                                                twitterLink:
                                                                    controller
                                                                        .text,
                                                              );
                                                          await repo
                                                              .updateHotline(
                                                                hotline: data,
                                                              );

                                                          ref.invalidate(
                                                            hotlineListProvider,
                                                          );
                                                          isLoading.value =
                                                              false;
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                          }
                                                          if (context.mounted) {
                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Hotlink updated!',
                                                                ),
                                                                backgroundColor:
                                                                    Color(
                                                                      0xff008000,
                                                                    ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                child: Container(
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          controller
                                                                  .text
                                                                  .isEmpty
                                                              ? Colors.grey
                                                              : Colors.green,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child:
                                                        isLoading.value
                                                            ? CircularProgressIndicator()
                                                            : Text(
                                                              "Save",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                );
                              },
                              child: Image.asset(
                                'assets/edit.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .8,
                              ),
                              child: Text(
                                "Phone Number: ${hotline.phoneNumber.isNotEmpty ? hotline.phoneNumber : ".............................................."}",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => HookBuilder(
                                        builder: (context) {
                                          final TextEditingController
                                          controller = useTextEditingController(
                                            text: hotline.phoneNumber,
                                          );
                                          final isLoading = useState(false);
                                          return AlertDialog(
                                            title: Text("Edit"),
                                            content: SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  .8,
                                              child: TextFormField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                  hintText: "Enter Phone",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.phone,

                                                onChanged: (value) {
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                              ),
                                            ),
                                            actions: [
                                              InkWell(
                                                onTap:
                                                    controller.text.isEmpty
                                                        ? null
                                                        : () async {
                                                          isLoading.value =
                                                              true;
                                                          final repo = await ref
                                                              .read(
                                                                hotlineRepoProvider
                                                                    .future,
                                                              );
                                                          final data = hotline
                                                              .copyWith(
                                                                phoneNumber:
                                                                    controller
                                                                        .text,
                                                              );
                                                          await repo
                                                              .updateHotline(
                                                                hotline: data,
                                                              );

                                                          ref.invalidate(
                                                            hotlineListProvider,
                                                          );
                                                          isLoading.value =
                                                              false;
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                          }
                                                          if (context.mounted) {
                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Hotlink updated!',
                                                                ),
                                                                backgroundColor:
                                                                    Color(
                                                                      0xff008000,
                                                                    ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                child: Container(
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          controller
                                                                  .text
                                                                  .isEmpty
                                                              ? Colors.grey
                                                              : Colors.green,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child:
                                                        isLoading.value
                                                            ? CircularProgressIndicator()
                                                            : Text(
                                                              "Save",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                );
                              },
                              child: Image.asset(
                                'assets/edit.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .8,
                              ),
                              child: Text(
                                "Location: ${hotline.location.isNotEmpty ? hotline.location : ".............................................."}",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => HookBuilder(
                                        builder: (context) {
                                          final TextEditingController
                                          controller = useTextEditingController(
                                            text: hotline.location,
                                          );
                                          final isLoading = useState(false);
                                          return AlertDialog(
                                            title: Text("Edit"),
                                            content: SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  .8,
                                              child: TextFormField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                  hintText: "Enter Location",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  (context as Element)
                                                      .markNeedsBuild();
                                                },
                                              ),
                                            ),
                                            actions: [
                                              InkWell(
                                                onTap:
                                                    controller.text.isEmpty
                                                        ? null
                                                        : () async {
                                                          isLoading.value =
                                                              true;
                                                          final repo = await ref
                                                              .read(
                                                                hotlineRepoProvider
                                                                    .future,
                                                              );
                                                          final data = hotline
                                                              .copyWith(
                                                                location:
                                                                    controller
                                                                        .text,
                                                              );
                                                          await repo
                                                              .updateHotline(
                                                                hotline: data,
                                                              );

                                                          ref.invalidate(
                                                            hotlineListProvider,
                                                          );
                                                          isLoading.value =
                                                              false;
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                          }
                                                          if (context.mounted) {
                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Hotlink updated!',
                                                                ),
                                                                backgroundColor:
                                                                    Color(
                                                                      0xff008000,
                                                                    ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                child: Container(
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          controller
                                                                  .text
                                                                  .isEmpty
                                                              ? Colors.grey
                                                              : Colors.green,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child:
                                                        isLoading.value
                                                            ? CircularProgressIndicator()
                                                            : Text(
                                                              "Save",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                );
                              },
                              child: Image.asset(
                                'assets/edit.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
