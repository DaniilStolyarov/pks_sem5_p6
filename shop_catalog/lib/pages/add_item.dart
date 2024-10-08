import 'package:flutter/material.dart';
import 'package:shop_catalog/models/shop_item.dart';
import 'package:shop_catalog/pages/catalog.dart';

class AddItem extends StatelessWidget {
  AddItem({super.key, required this.catalogState});
  final CatalogState catalogState;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageURLController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Добавить стрижку"),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Название",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Описание",
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: imageURLController,
                decoration: InputDecoration(
                  labelText: "URL картинки",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: "Цена",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 25, 64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.only(
                        left: 20.0, top: 10.0, right: 20.0, bottom: 10.0)),
                child: Text("Сохранить",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                onPressed: () {
                  ShopItem newItem = ShopItem(
                      -1,
                      titleController.text,
                      "Стрижка и укладка",
                      int.parse(priceController.text),
                      imageURLController.text,
                      descriptionController.text);
                  newItem.isImageUrl = true;
                  catalogState.addItem(newItem);
                  Navigator.pop(context);
                },
              ),
            ],
          )),
    );
  }
}
