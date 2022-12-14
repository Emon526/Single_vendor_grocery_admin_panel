import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/MenuController.dart';
import '../responsive.dart';
import '../services/utils.dart';
import '../widgets/button_widget.dart';
import '../widgets/header.dart';
import '../widgets/side_menu.dart';
import '../widgets/text_widget.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';
  const UploadProductForm({Key? key}) : super(key: key);

  @override
  State<UploadProductForm> createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  String _catValue = 'Vegetables';
  late final TextEditingController _titleController, _priceController;
  int _groupValue = 1;
  bool isPiece = false;

  File? _pickedImage;
  Uint8List webImage = Uint8List(8);

  @override
  void initState() {
    _priceController = TextEditingController();
    _titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _uploadForm() {
    final isValid = _formKey.currentState!.validate();
  }

  void _clearForm() {
    isPiece = false;
    _groupValue = 1;
    _priceController.clear();
    _titleController.clear();
    setState(() {
      _pickedImage = null;
      webImage = Uint8List(8);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: _scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.0),
      ),
    );
    return Scaffold(
      key: context.read<MenuController>().getAddProductscaffoldKey,
      drawer: const SideMenu(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              child: SideMenu(),
            ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Header(
                      title: 'Add Products',
                      showTextField: false,
                      fct: () {
                        context.read<MenuController>().controlAddProductsMenu();
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: size.width > 650 ? 650 : size.width,
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextWidget(
                              text: 'Product title',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _titleController,
                              key: const ValueKey('Title'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Title';
                                }
                                return null;
                              },
                              decoration: inputDecoration,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: FittedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: 'Price in \$*',
                                          color: color,
                                          isTitle: true,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: TextFormField(
                                            controller: _priceController,
                                            key: const ValueKey('Price \$'),
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Price is missed';
                                              }
                                              return null;
                                            },
                                            decoration: inputDecoration,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9.]'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextWidget(
                                          text: 'Product category',
                                          color: color,
                                          isTitle: true,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // dropdown
                                        _categoryDropDown(),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextWidget(
                                          text: 'Measre unit',
                                          color: color,
                                          isTitle: true,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // radio button
                                        Row(
                                          children: [
                                            TextWidget(
                                              text: 'KG',
                                              color: color,
                                            ),
                                            Radio(
                                              value: 1,
                                              groupValue: _groupValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _groupValue = 1;
                                                  isPiece = false;
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                            TextWidget(
                                              text: 'Piece',
                                              color: color,
                                            ),
                                            Radio(
                                              value: 2,
                                              groupValue: _groupValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _groupValue = 2;
                                                  isPiece = true;
                                                });
                                              },
                                              activeColor: Colors.green,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //image to be picked
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: size.width > 650
                                        ? 350
                                        : size.width * 0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    child: _pickedImage == null
                                        ? dottedBorder(color: color)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: kIsWeb
                                                ? Image.memory(
                                                    webImage,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.file(
                                                    _pickedImage!,
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _pickedImage = null;
                                              webImage = Uint8List(8);
                                            });
                                          },
                                          child: TextWidget(
                                            text: 'Clear image',
                                            color: Colors.red,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: TextWidget(
                                            text: 'Upload image',
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ButtonWidget(
                                    onpressed: () {
                                      _clearForm();
                                    },
                                    text: 'Clear form',
                                    icon: IconlyBold.danger,
                                    backgroundColor: Colors.red.shade300,
                                  ),
                                  ButtonWidget(
                                    onpressed: () {
                                      _uploadForm();
                                    },
                                    text: 'Upload',
                                    icon: IconlyBold.upload,
                                    backgroundColor: Colors.blue,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        log('No Image Picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        log('No Image Picked');
      }
    } else {
      log('Something wemt Wrong');
    }
  }

  Widget dottedBorder({required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        dashPattern: const [6.7],
        borderType: BorderType.RRect,
        color: color,
        radius: const Radius.circular(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                color: color,
                size: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: TextWidget(
                    text: 'Choose an image',
                    color: Colors.blue,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryDropDown() {
    Color color = Utils(context).color;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: color,
            ),
            value: _catValue,
            items: const [
              DropdownMenuItem(
                value: 'Vegetables',
                child: Text(
                  'Vegetables',
                ),
              ),
              DropdownMenuItem(
                value: 'Fruits',
                child: Text(
                  'Fruits',
                ),
              ),
              DropdownMenuItem(
                value: 'Grains',
                child: Text(
                  'Grains',
                ),
              ),
              DropdownMenuItem(
                value: 'Nuts',
                child: Text(
                  'Nuts',
                ),
              ),
              DropdownMenuItem(
                value: 'Herbs',
                child: Text(
                  'Herbs',
                ),
              ),
              DropdownMenuItem(
                value: 'Spices',
                child: Text(
                  'Spices',
                ),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _catValue = value!;
                log(_catValue);
              });
            },
            hint: const Text('Select a category'),
          ),
        ),
      ),
    );
  }
}
