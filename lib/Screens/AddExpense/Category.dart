import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  TextEditingController categoryController = TextEditingController();
  List<Map<String, String>> categoriesIcon = [
    {'image': "lib/assets/entertainment.png", 'name': "Entertainment"},
    {'image': "lib/assets/food.png", 'name': "Food"},
    {'image': "lib/assets/home.png", 'name': "Home"},
    {'image': "lib/assets/pet.png", 'name': "Pets"},
    {'image': "lib/assets/shopping.png", 'name': "Shopping"},
    {'image': "lib/assets/medical.jpg", 'name': "Medical"},
    {'image': "lib/assets/monthlyBills.png", 'name': "Monthly Bills"},
    {'image': "lib/assets/technology.png", 'name': "Technology"},
    {'image': "lib/assets/travel.png", 'name': "Travel"},
    {'image': "lib/assets/others.png", 'name': "Others"},
  ];

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      readOnly: true,
      controller: categoryController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            FontAwesomeIcons.plus,
            size: 16,
            color: Colors.grey,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) {
                bool isExpanded = false;
                String iconSelected = "";
                Color categoryColor = Colors.white;
                int i ;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text("Create a Category"),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              onTap: () {},
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Name",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              readOnly: true,
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                suffixIcon: isExpanded
                                    ? Icon(
                                  CupertinoIcons.chevron_up,
                                  size: 12,
                                )
                                    : Icon(
                                  CupertinoIcons.chevron_down,
                                  size: 12,
                                ),
                                fillColor: Colors.white,
                                hintText:  iconSelected == "" ? "Select Icon"  : "Icon Selected",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: isExpanded
                                      ? BorderRadius.vertical(
                                      top: Radius.circular(12))
                                      : BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            if (isExpanded)
                              Container(
                                width:
                                MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(12),
                                  ),
                                ),
                                child: GridView.builder(
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                                  itemCount: categoriesIcon.length,
                                  itemBuilder: (context, int i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          iconSelected =
                                          categoriesIcon[i]
                                          ['image']!;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 4,
                                              color: iconSelected ==
                                                  categoriesIcon[
                                                  i]["image"]!
                                                  ? Colors.green
                                                  : Colors.grey,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(
                                                12)),
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(10.0),
                                              child: Image.asset(
                                                categoriesIcon[i]
                                                ['image']!,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(categoriesIcon[i]
                                            ['name']!)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            SizedBox(height: 16),
                            TextFormField(
                              readOnly: true,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (cnt2) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          children: [
                                            ColorPicker(
                                                pickerColor:
                                                Colors.white,
                                                onColorChanged:
                                                    (value) {
                                                  setState(() {
                                                    categoryColor = value;
                                                  });
                                                }),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 50,
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(cnt2);
                                                },
                                                child: Text(
                                                  "Save",
                                                  style: TextStyle(fontSize: 22, color: Colors.white),
                                                ),
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor:categoryColor ,
                                hintText: categoryColor == Colors.white ? "Select Color" : "",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(height: 16,),
                            SizedBox(
                              width: double.infinity,
                              height: kToolbarHeight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Save",
                                  style: TextStyle(fontSize: 22, color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          FontAwesomeIcons.list,
          size: 16,
          color: Colors.grey,
        ),
        hintText: "Category",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
