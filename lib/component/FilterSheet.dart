import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class FilterOffer extends StatefulWidget {
  BuildContext context;
  FilterOffer({Key? key, required this.context}) : super(key: key);
  @override
  State<FilterOffer> createState() => _FilterOfferState();
}

class _FilterOfferState extends State<FilterOffer> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("For rent"), value: "rent"),
      const DropdownMenuItem(child: Text("For sale"), value: "sale"),
    ];
    return menuItems;
  }

  int current = 0;
  Map<String, String> parametres = {};
  String dropdownValue = 'rent';
  String selectedValue = "rent";
  RangeValues _currentRangeValues = const RangeValues(40, 400000);
  List<String> roomnumber = ['Any', '1', '2', '3', '4', '5', '6', '7', '8'];
  // show filtred announces
  // var announcelist = <Announce>[];
  // showfiltredannounces(Map<String, String> parametres) async {
  //   Response response = await AnnounceController.filterAnnounce(parametres);
  //   if (response.statusCode == 200) {
  //     Iterable list = json.decode(response.body);
  //     try {
  //       announcelist = list.map((model) => Announce.fromJson(model)).toList();
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     print(response.body);
  //   }
  // }

  // show filtred announces
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.9,
      minChildSize: 0.8,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: ListView(
          controller: controller,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Text(
                  'Filters',
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () async {
                    // await showfiltredannounces(parametres);
                    print(parametres);
                    setState(() {
                      parametres = {};
                    });
                    // showModalBottomSheet(
                    //     isDismissible: true,
                    //     isScrollControlled: true,
                    //     backgroundColor: Colors.transparent,
                    //     context: context,
                    //     builder: (context) =>
                    //         AnnounceColumn(announces: announcelist));

                  },
                  child: const Text('apply'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Price Range',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(_currentRangeValues.start.round().toString() +
                    '\$' +
                    '-' +
                    _currentRangeValues.end.round().toString() +
                    '\$'),
                RangeSlider(
                  values: _currentRangeValues,
                  max: 400000,
                   divisions: 200,
                  // labels: RangeLabels(
                  //   _currentRangeValues.start.round().toString(),
                  //   _currentRangeValues.end.round().toString(),
                  // ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      parametres['minprice'] =
                          _currentRangeValues.start.round().toString();
                      parametres['maxprice'] =
                          _currentRangeValues.end.round().toString();
                      _currentRangeValues = values;
                    });
                  },
                ),
                const Divider(
                  thickness: 1.2,
                ),
                const Text(
                  'Rooms',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: roomnumber.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                              if (index > 0) {
                                parametres['roomnumber'] = roomnumber[index];
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            width: 80,
                            height: 45,
                            decoration: BoxDecoration(
                              color: current == index
                                  ? Colors.white70
                                  : Colors.white54,
                              borderRadius: current == index
                                  ? BorderRadius.circular(15)
                                  : BorderRadius.circular(10),
                              border: current == index
                                  ? Border.all(
                                      color: Colors.deepPurpleAccent, width: 2)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                roomnumber[index],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1.2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Deal type',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      // elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          parametres['dealtype'] = newValue!;
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['rent', 'Sale']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
                const Divider(
                  thickness: 1.2,
                ),
                const Text(
                  'Proprety type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {
                                parametres['propretytype'] = 'villa';
                              },
                              icon: const Icon(Icons.house_rounded),
                              label: Text('Villa')),
                          ElevatedButton.icon(
                              onPressed: () {
                                parametres['propretytype'] = 'Appartement';
                              },
                              icon: const Icon(Icons.apartment_rounded),
                              label: Text(' Appartment'))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {
                                parametres['propretytype'] = 'studio';
                              },
                              icon: const Icon(Icons.bedroom_parent_rounded),
                              label: Text('Studio')),
                          ElevatedButton.icon(
                              onPressed: () {
                                parametres['propretytype'] = 'land';
                              },
                              icon: const Icon(Icons.fullscreen),
                              label: Text('land')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
