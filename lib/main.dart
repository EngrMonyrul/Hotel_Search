import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int room = 1;
  int adult = 1;
  int child = 0;
  List<int> childAge = [];
  List<RoomGuest> totalGuests = [
    RoomGuest(
      adult: 1,
      child: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CupertinoColors.systemGrey5,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Hotel",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        // height: MediaQuery.of(context).size.height * .7,
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 60,
                        ),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 30, bottom: 45),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HotelSelectionItem(
                              title: "Select Country or City",
                              value: "Dhaka, Bangladesh",
                            ),
                            const SizedBox(height: 15),
                            const HotelSelectionItem(
                              title: "Nationality",
                              value: "Bangladeshi",
                            ),
                            const SizedBox(height: 15),
                            const HotelSelectionItem(
                              title: "Check In Date",
                              value: "21 May, 2024",
                            ),
                            const SizedBox(height: 15),
                            const HotelSelectionItem(
                              title: "Check Out Date",
                              value: "27 May, 2024",
                            ),
                            const SizedBox(height: 15),
                            const HotelSelectionItem(
                              title: "Check Out Date",
                              value: "27 May, 2024",
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                HotelGuestButton(
                                  value: "0${totalGuests.length}",
                                  label: "Room",
                                  pressedOnIncreased: () {
                                    setState(() {
                                      RoomGuest roomGuest = RoomGuest(
                                        child: 0,
                                        adult: 1,
                                      );
                                      if (totalGuests.length < 4) {
                                        room++;
                                        totalGuests.add(roomGuest);
                                      }
                                    });
                                  },
                                  pressedOnDecrease: () {
                                    setState(() {
                                      if (totalGuests.length > 1) {
                                        room--;
                                        totalGuests.removeLast();
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(width: 35),
                                Column(
                                  children: List.generate(room, (index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            HotelGuestButton(
                                              value:
                                                  "0${totalGuests[index].adult}",
                                              label: "Adult",
                                              pressedOnIncreased: () {
                                                setState(() {
                                                  if (totalGuests[index]
                                                          .adult! <
                                                      2) {
                                                    final adultValue =
                                                        totalGuests[index]
                                                                .adult! +
                                                            1;
                                                    totalGuests[index].adult =
                                                        adultValue;
                                                  }
                                                });
                                              },
                                              pressedOnDecrease: () {
                                                setState(() {
                                                  if (totalGuests[index]
                                                          .adult! >
                                                      1) {
                                                    final adultValue =
                                                        totalGuests[index]
                                                                .adult! -
                                                            1;
                                                    totalGuests[index].adult =
                                                        adultValue;
                                                  }
                                                });
                                              },
                                            ),
                                            const SizedBox(width: 35),
                                            HotelGuestButton(
                                              value:
                                                  "0${totalGuests[index].child}",
                                              label: "Children",
                                              pressedOnDecrease: () {
                                                setState(() {
                                                  if (totalGuests[index]
                                                          .child! >
                                                      0) {
                                                    final childValue =
                                                        totalGuests[index]
                                                                .child! -
                                                            1;
                                                    totalGuests[index].child =
                                                        childValue;
                                                  }
                                                });
                                              },
                                              pressedOnIncreased: () {
                                                setState(() {
                                                  if (totalGuests[index]
                                                          .child! <
                                                      2) {
                                                    final childValue =
                                                        totalGuests[index]
                                                                .child! +
                                                            1;
                                                    totalGuests[index].child =
                                                        childValue;
                                                  }
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: List.generate(
                                              totalGuests[index].child!,
                                              (index2) {
                                            return DropdownMenu<int>(
                                              onSelected: (value) {
                                                setState(() {
                                                  totalGuests[index]
                                                      .ages![index2] = value!;
                                                });
                                              },
                                              label: const Text(
                                                "Children Age",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                ),
                                              ),
                                              dropdownMenuEntries:
                                                  List.generate(10, (index) {
                                                return DropdownMenuEntry<int>(
                                                  label: "${index + 2}",
                                                  value: index + 2,
                                                );
                                              }).toList(),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .7 + 100,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 160,
                    child: GestureDetector(
                      onTap: () {
                        debugPrint(
                            "\n\n|=======================> Output : $totalGuests}|---->  \n\n ");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text("Search"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class HotelGuestButton extends StatelessWidget {
  const HotelGuestButton({
    super.key,
    this.pressedOnIncreased,
    this.pressedOnDecrease,
    this.value,
    this.label,
  });

  final VoidCallback? pressedOnIncreased;
  final VoidCallback? pressedOnDecrease;
  final String? value;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label ?? "Label",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            InkWell(
              onTap: pressedOnDecrease,
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: CupertinoColors.systemGrey5,
                child: Icon(
                  CupertinoIcons.minus,
                  size: 15,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: 20,
              child: Text(value ?? "00"),
            ),
            InkWell(
              onTap: pressedOnIncreased,
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: CupertinoColors.systemGrey5,
                child: Icon(
                  CupertinoIcons.add,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HotelSelectionItem extends StatelessWidget {
  const HotelSelectionItem({
    super.key,
    this.title,
    this.value,
    this.onPressed,
  });

  final String? title;
  final String? value;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "Label",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(value ?? "Value"),
          ),
        ),
      ],
    );
  }
}

class RoomGuest {
  int? child;
  int? adult;
  List<int>? ages;

  RoomGuest({this.child, this.adult, this.ages});

  RoomGuest copyWith(
    int? child,
    int? adult,
    List<int>? ages,
  ) =>
      RoomGuest(
        child: child ?? this.child,
        adult: adult ?? this.adult,
        ages: ages ?? this.ages,
      );
}
