import 'package:android_midterm/models/item.dart';
import 'package:android_midterm/models/location.dart';
import 'package:android_midterm/models/order_model.dart';
import 'package:android_midterm/provider/order_provider.dart';
import 'package:android_midterm/provider/page_num_provider.dart';
import 'package:android_midterm/provider/picker_provider.dart';
import 'package:android_midterm/screens/map_picker_v2.dart';
import 'package:android_midterm/screens/order_screen.dart';
import 'package:android_midterm/utils/user_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

class AddOrder extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const AddOrder({Key? key, this.docs_id}) : super(key: key);

  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  final String? docs_id;

  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  // ignore: non_constant_identifier_names
  final _item_name_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final _amount_controller = TextEditingController();
  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  final _name_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final _phone_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final _desc_controller = TextEditingController();

  // ignore: non_constant_identifier_names
  final _form_key = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  DateTime _date_picker = DateTime.now();
  OrderModel object = OrderModel();

  Future<void> _loadData() async {
    String uid = await SecureStorage.readSecureData(SecureStorage.userID);
    await object.fetchOrder(widget.docs_id, uid);
  }

  Future<void> _initState() async {
    String uid = await SecureStorage.readSecureData(SecureStorage.userID);
  }

  @override
  void initState() {
    super.initState();
    if (widget.docs_id == null) {
      print("null");
      _initState().then((value) {
        // _name_controller.text = object.name;
        // _phone_controller.text = object.phone;
        // _desc_controller.text = object.note;
        // _date_picker = object.dueDate;
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          var _order_provider =
              Provider.of<OrderProvider>(context, listen: false);
          // ignore: non_constant_identifier_names
          var _picker_provider =
              Provider.of<PickerProvider>(context, listen: false);
          _order_provider.clear();
          _picker_provider.load_location(Location(
              lat: object.location.latitude,
              lng: object.location.longitude,
              formattedAddress: "",
              name: ""));
          setState(() {});
        });
      });
      return;
    }
    _loadData().then((value) {
      _name_controller.text = object.name;
      _phone_controller.text = object.phone;
      _desc_controller.text = object.note;
      _date_picker = object.dueDate;
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        var _order_provider =
            Provider.of<OrderProvider>(context, listen: false);
        // ignore: non_constant_identifier_names
        var _picker_provider =
            Provider.of<PickerProvider>(context, listen: false);
        _order_provider.clear();
        for (var item in object.products) {
          _order_provider.AddItem(ItemOrder(item.name, item.qua));
        }
        _picker_provider.load_location(Location(
            lat: object.location.latitude,
            lng: object.location.longitude,
            formattedAddress: object.address,
            name: object.address));
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageNumModel = Provider.of<PageNumProvider>(context);
    // ignore: non_constant_identifier_names
    var _order_provider = Provider.of<OrderProvider>(context);
    // ignore: non_constant_identifier_names
    var _picker_provider = Provider.of<PickerProvider>(context);
    // ignore: non_constant_identifier_names
    var _list_item = _order_provider.list_item;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            context.router.pop();
          },
        ),
        title: const Text(
          "Chi tiết đơn đặt hàng",
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            Column(
              children: [
                const SizedBox(height: 5),
                TextField(
                  controller: _name_controller,
                  textAlignVertical: const TextAlignVertical(y: 0.5),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tên người đặt',
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(Icons.person)),
                ),
                const SizedBox(height: 10),
                Divider(thickness: 20, color: Colors.grey.shade300),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 5),
                TextField(
                  controller: _phone_controller,
                  textAlignVertical: const TextAlignVertical(y: 0.5),
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Số điện thoại',
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(Icons.phone)),
                ),
                const SizedBox(height: 10),
                Divider(thickness: 20, color: Colors.grey.shade300),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 5),
                TextField(
                  controller: _desc_controller,
                  textAlignVertical: const TextAlignVertical(y: 0.5),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Miêu tả',
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(Icons.description)),
                ),
                const SizedBox(height: 10),
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
                      maxHeight: MediaQuery.of(context).size.height / 5),
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
                          title: "Thêm sản phẩm",
                          content: Column(
                            children: [
                              AddItemField(
                                item_name_field_controller:
                                    _item_name_controller,
                                amount_field_controller: _amount_controller,
                                form_key: _form_key,
                              ),
                            ],
                          ),
                          buttons: [
                            DialogButton(
                                child: const Text(
                                  "Lưu",
                                  style: TextStyle(color: Colors.white),
                                ),
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
                                child: const Text(
                                  "Hủy",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => Navigator.pop(context))
                          ]).show();
                      _item_name_controller.clear();
                      _amount_controller.clear();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
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
                                "Thêm sản phẩm",
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
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Wrap(
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
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Text(
                                  _picker_provider.current_location.name.isEmpty
                                      ? "Chọn địa điểm"
                                      : _picker_provider.current_location.name,
                                  maxLines: 5,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      color: Colors.blue, fontSize: 16),
                                ),
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
            // const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: _date_picker,
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2030))
                      .then((value) {
                    if (value == null) return;
                    setState(() {
                      // ignore: avoid_print
                      _date_picker =
                          DateTime(value.year, value.month, value.day);
                      print(_date_picker);
                    });
                  });
                  await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                              hour: DateTime.now().hour,
                              minute: DateTime.now().minute))
                      .then((value) {
                    if (value == null) return;
                    setState(() {
                      _date_picker = DateTime(
                          _date_picker.year,
                          _date_picker.month,
                          _date_picker.day,
                          value.hour,
                          value.minute);
                    });
                  });
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
                          SizedBox(height: 13),
                          Icon(
                            Icons.calendar_today,
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
                            _date_picker.hour.toString() +
                                ":" +
                                _date_picker.minute.toString() +
                                " " +
                                _date_picker.day.toString() +
                                '/' +
                                _date_picker.month.toString() +
                                '/' +
                                _date_picker.year.toString(),
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
            ),
            const SizedBox(
              height: 10,
            ),
          ]))),
          GestureDetector(
              onTap: () async {
                String uid =
                    await SecureStorage.readSecureData(SecureStorage.userID);
                var name = _name_controller.text;
                var phone = _phone_controller.text;
                var note = _desc_controller.text;
                if (widget.docs_id != null) {
                  var data = <String, dynamic>{};
                  data["name"] = name;
                  data["phone_number"] = phone;
                  data["location"] = GeoPoint(
                      _picker_provider.current_location.lat,
                      _picker_provider.current_location.lng);
                  data["note"] = note;
                  data["address"] =
                      _picker_provider.current_location.formattedAddress;
                  data["enable"] = object.enable;
                  String uid =
                      await SecureStorage.readSecureData(SecureStorage.userID);
                  data["created_by"] = uid;
                  data["products"] = [];
                  data["due_date"] = Timestamp.fromDate(_date_picker);
                  for (var i = 0; i < _list_item.length; i++) {
                    var temp = {
                      "name": _list_item[i].item_name,
                      "qua": _list_item[i].amount
                    };
                    data["products"].add(temp);
                  }
                  final firestoreInstance = FirebaseFirestore.instance;
                  await firestoreInstance
                      .collection("donhang")
                      .doc(widget.docs_id)
                      .update(data)
                      .catchError((onError) => print(onError));
                  _picker_provider.init();
                  pageNumModel.pageNum = 1;
                  context.router.pushNamed('/dashboard');
                  return;
                }
                await _order_provider.SaveOrder(
                    name,
                    phone,
                    note,
                    GeoPoint(_picker_provider.current_location.lat,
                        _picker_provider.current_location.lng),
                    _picker_provider.current_location.formattedAddress,
                    uid,
                    _date_picker);
                _picker_provider.init();
                pageNumModel.pageNum = 1;
                context.router.pushNamed('/dashboard');
              },
              child: Container(
                  margin: const EdgeInsets.all(10.0),
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.blue[200]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.save, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Lưu',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ],
                      )))),
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
              title: "Thêm sản phẩm",
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
                    child: const Text("Lưu"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        orderProvider.UpdateItem(
                            ItemOrder(itemNameController.text.toString(),
                                int.parse(amountController.text.toString())),
                            index);
                        itemNameController.clear();
                        amountController.clear();
                        context.router.pop();
                      }
                    }),
                DialogButton(
                    child: const Text("Delete"),
                    onPressed: () {
                      orderProvider.DeleteItem(index);
                      itemNameController.clear();
                      amountController.clear();
                      context.router.pop();
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
                hintText: 'Tên sản phẩm',
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
              hintText: 'Số lượng',
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
