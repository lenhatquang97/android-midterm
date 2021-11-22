import 'package:android_midterm/models/item.dart';
import 'package:android_midterm/provider/order_provider.dart';
import 'package:android_midterm/provider/picker_provider.dart';
import 'package:android_midterm/screens/map_picker_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({Key? key}) : super(key: key);

  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  // ignore: non_constant_identifier_names
  final _item_name_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final _amount_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final _form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    var _order_provider = Provider.of<OrderProvider>(context);
    // ignore: non_constant_identifier_names
    var _picker_provider = Provider.of<PickerProvider>(context);
    // ignore: non_constant_identifier_names
    var _list_item = _order_provider.list_item;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Order Details",
        ),
      ),
      body: Column(
        children: [
          Column(
            children: const [
              SizedBox(height: 5),
              TextField(
                textAlignVertical: TextAlignVertical(y: 0.5),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description (Optional)',
                    hintStyle: TextStyle(fontSize: 16),
                    prefixIcon: Icon(Icons.description)),
              ),
              SizedBox(height: 10),
            ],
          ),
          Column(
            children: [
              Divider(
                thickness: 20,
                color: Colors.grey.shade300,
              ),
              Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 3),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _list_item.length,
                  itemBuilder: (_, index) => ItemWidget(
                      item: _list_item[index],
                      index: index,
                      isLastItem: index == _list_item.length - 1,
                      orderProvider: _order_provider,
                      itemNameController: _item_name_controller,
                      amountController: _amount_controller,
                      formKey: _form_key),
                ),
              ),
              _list_item.isNotEmpty
                  ? Divider(
                      thickness: 20,
                      color: Colors.grey.shade300,
                    )
                  : const SizedBox(),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                  // ignore: void_checks
                  onPressed: () {
                    Alert(
                        context: context,
                        title: "Add item",
                        content: Column(
                          children: [
                            AddItemField(
                              item_name_field_controller: _item_name_controller,
                              amount_field_controller: _amount_controller,
                              form_key: _form_key,
                            ),
                          ],
                        ),
                        buttons: [
                          DialogButton(
                              child: const Text("Save"),
                              onPressed: () {
                                if (_form_key.currentState!.validate()) {
                                  _order_provider.AddItem(
                                    ItemOrder(
                                        _item_name_controller.text.toString(),
                                        int.parse(_amount_controller.text
                                            .toString())),
                                  );
                                  Navigator.pop(context);
                                }
                              }),
                          DialogButton(
                              child: const Text("Cancel"),
                              onPressed: () => Navigator.pop(context))
                        ]).show();
                    _item_name_controller.clear();
                    _amount_controller.clear();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Column(
                          children: const [
                            SizedBox(height: 15),
                            Icon(
                              Icons.add_circle,
                              color: Colors.blue,
                              size: 25,
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: const [
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Add item",
                              textAlign: TextAlign.justify,
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              Divider(
                thickness: 20,
                color: Colors.grey.shade300,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapScreen()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Column(
                          children: const [
                            SizedBox(height: 15),
                            Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 25,
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              _picker_provider.current_location.name.isEmpty
                                  ? "Choose location"
                                  : _picker_provider.current_location.name,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              Divider(
                thickness: 20,
                color: Colors.grey.shade300,
              )
            ],
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(height: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        print('poped');
                      },
                      child: const Text("Luu"),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15)))),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.item,
    required this.index,
    required this.isLastItem,
    // ignore: non_constant_identifier_names
    required this.orderProvider,
    required this.itemNameController,
    required this.formKey,
    required this.amountController,
  }) : super(key: key);

  final ItemOrder item;
  final int index;
  final bool isLastItem;
  // ignore: prefer_typing_uninitialized_variables
  final orderProvider;
  // ignore: prefer_typing_uninitialized_variables
  final itemNameController;
  // ignore: prefer_typing_uninitialized_variables
  final formKey;
  // ignore: prefer_typing_uninitialized_variables
  final amountController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          itemNameController.text = item.item_name;
          amountController.text = item.amount.toString();
          Alert(
              context: context,
              title: "Add item",
              content: Column(
                children: [
                  AddItemField(
                    item_name_field_controller: itemNameController,
                    amount_field_controller: amountController,
                    form_key: formKey,
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                    child: const Text("Save"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        orderProvider.UpdateItem(
                            ItemOrder(itemNameController.text.toString(),
                                int.parse(amountController.text.toString())),
                            index);
                        itemNameController.clear();
                        amountController.clear();
                        Navigator.pop(context);
                      }
                    }),
                DialogButton(
                    child: const Text("Delete"),
                    onPressed: () {
                      orderProvider.DeleteItem(index);
                      itemNameController.clear();
                      amountController.clear();
                      Navigator.pop(context);
                    })
              ]).show();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Column(
          children: [
            index == 0
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox(),
            SizedBox(
              height: 45,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.item_name,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    child: Text(
                      item.amount.toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            (!isLastItem)
                ? Divider(
                    thickness: 1,
                    color: Colors.grey.shade300,
                  )
                : const SizedBox(
                    height: 10,
                  ),
          ],
        ));
  }
}

class AddItemField extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final TextEditingController item_name_field_controller;
  // ignore: non_constant_identifier_names
  final TextEditingController amount_field_controller;
  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> form_key;

  const AddItemField(
      {Key? key,
      // ignore: non_constant_identifier_names
      required this.item_name_field_controller,
      // ignore: non_constant_identifier_names
      required this.amount_field_controller,
      // ignore: non_constant_identifier_names
      required this.form_key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form_key,
      child: Column(
        children: [
          TextFormField(
              controller: item_name_field_controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter item name';
                }
                return null;
              },
              textAlignVertical: const TextAlignVertical(y: 0),
              decoration: const InputDecoration(
                hintText: 'Item name',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
              )),
          Divider(
            thickness: 1,
            color: Colors.grey.shade300,
          ),
          TextFormField(
            controller: amount_field_controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter amount';
              } else {
                if (int.parse(value) < 0) {
                  return 'Amount value can not negative';
                }
              }
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 15),
              hintText: 'Amount',
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
