import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hallmarkcardgenerator/Model/Helper.dart';
import 'package:hallmarkcardgenerator/PdfGenerator.dart';
import 'package:hallmarkcardgenerator/Model/InputFields.dart';
import 'package:hallmarkcardgenerator/objectbox.g.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hallmarkcardgenerator/imageUtil.dart';
import 'package:pdf/pdf.dart';

class FormScreen extends StatefulWidget {
  static const routeName = '/Form';

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Uint8List _image;
  bool image = false;
  ImageHelper imh = ImageHelper();
  ViewModel _vm;
  bool isDbOpen = true;
  Iterable<String> listOfItemName;

  @override
  void initState() {
    super.initState();
    print('form Screen Init ,is dbopen${isDbOpen}');
    try {
      openStore().then((Store store) {
        print('err');
        _vm = ViewModel(store);
        listOfItemName=_vm.all_Item_Name().map((e) => e.item_name);
        // isDbOpen = true;
        print('form Screen Init ,is dbopen${isDbOpen}');
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    try {
      if (isDbOpen) {
        print('form Screen dispose ,is dbopen${isDbOpen}');
        _vm.dispose();
        //  isDbOpen = false;
        print('form Screen dispose ,is dbopen${isDbOpen}');
      }
    } catch (e) {
      print(e.toString());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    var args = ModalRoute.of(context).settings.arguments as InputField;
//
//    if (args != null) {
//      _image = args.img;
//    } else {
//      args = InputField(
//        name: '',
//        item_name: '',
//        grosswt: 0,
//        netwt: 0,
//        purity: '',
//        certificate_no: 0,
//      );
//    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FormBuilderTextField(
                      //  initialValue: args.name,
                      name: 'name',
                      decoration: InputDecoration(labelText: 'Jeweller Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Fill'),
                      ]),
                    ),
                    FormBuilderTextField(
                      //  initialValue: args.item_name,
                      name: 'item_name',
                      autocorrect: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofillHints: <String>['heellp','hello1','ring'],
                      decoration: InputDecoration(labelText: 'Item Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'grosswt',
                      // initialValue: args.grosswt.toString(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                        FormBuilderValidators.numeric(context,errorText: 'Enter a Number only'),
                      ]),

                      decoration: InputDecoration(labelText: 'Gross Wt'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                    FormBuilderTextField(
                      name: 'netwt',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                        FormBuilderValidators.numeric(context,errorText: 'Enter a Number only'),
                      ]),

                      //   initialValue: args.netwt.toString(),
                      decoration: InputDecoration(labelText: 'Net wt'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                    FormBuilderTextField(
                      name: 'purity',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                      ]),

                      //  initialValue: args.purity,
                      decoration: InputDecoration(labelText: 'Purity'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                    ),
                    FormBuilderTextField(
                      name: 'remark',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                      ]),

                      //  initialValue: args.remark,
                      decoration: InputDecoration(labelText: 'Remark'),
                    ),
                    FormBuilderTextField(
                      name: 'certificate_no',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                        FormBuilderValidators.numeric(context,errorText: 'Enter a Number only'),
                      ]),

                      //  initialValue: args.certificate_no.toString(),
                      decoration: InputDecoration(labelText: 'Certificate No'),
                      keyboardType: TextInputType.numberWithOptions(),
                    ),
                    FormBuilderTextField(
                      name: 'huid',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                      ]),

                      //  initialValue: args.certificate_no.toString(),
                      decoration: InputDecoration(labelText: 'huid'),
                      keyboardType: TextInputType.numberWithOptions(),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        PickedFile imagePickedFile =
                            await imh.getPickedImage(ImageSource.gallery);
                        print('PickedFile Image Path ${imagePickedFile.path}');
                        File cropimage =
                            await imh.getCroppedFile(imagePickedFile.path);

                        setState(() {
                          _image = cropimage.readAsBytesSync();
                          imagePickedFile = null;
                          cropimage.deleteSync();
                          image = true;
                        });
                      },
                      child: Text('Gallary')),
                  image == false
                      ? Container(
                          child: Center(child: Text('Upload Image')),
                          width: 2.8 * PdfPageFormat.cm,
                          height: 2.5 * PdfPageFormat.cm,
                          margin: EdgeInsets.fromLTRB(11, 9, 11, 3),
                          color: Colors.white70,
                        )
                      : Image.memory(
                          _image,
                          width: 2.8 * PdfPageFormat.cm,
                          height: 2.5 * PdfPageFormat.cm,
                        ),
                  ElevatedButton(
                      onPressed: () async {
                        PickedFile imagePickedFile =
                            await imh.getPickedImage(ImageSource.camera);
                        print('PickedFile Image Path ${imagePickedFile.path}');
                        File cropimage =
                            await imh.getCroppedFile(imagePickedFile.path);
                        //var adir = Directory(imagePickedFile.path).parent;
                        setState(() {
                          _image = cropimage.readAsBytesSync();
                          cropimage.deleteSync();
                          image = true;
                          //adir.deleteSync();
                        });
                      },
                      child: Text('Camera'))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              ElevatedButton(
                  onPressed: () async {
                    //  List<InputField> list = <InputField>[];
                    if (image || _formKey.currentState.validate()) {
                      _formKey.currentState.save();

//                      InputField obj = new InputField(
//                          name: 'abhjsi',
//                          item_name: 'jsch',
//                          grosswt: 55.00,
//                          netwt: 56.00,
//                          purity: '999',
//                          certificate_no: 12345,
//                          img: _image,
//                          huid: 'huid');
                      InputField obj = new InputField(
                        name: _formKey.currentState.value['name'],
                        item_name: _formKey.currentState.value['item_name'],
                        grosswt: double.parse(
                            _formKey.currentState.value['grosswt']),
                        netwt:
                            double.parse(_formKey.currentState.value['netwt']),
                        purity: _formKey.currentState.value['purity'],
                        certificate_no: int.parse(
                            _formKey.currentState.value['certificate_no']),
                        img: _image,
                        huid: _formKey.currentState.value['huid'],
                      );
                      // list.add(obj);
                      //  ViewModel _vm = ViewModel(await openStore());
                      if(!listOfItemName.contains(_formKey.currentState.value['item_name'])){
                        ItemName itmn=ItemName(item_name: _formKey.currentState.value['item_name']);
                        _vm.addItemName(itmn);
                      }
                      _vm.addCard(obj);

                      //_vm.dispose();
                      Navigator.pop(
                        context,
                      );
                    } else {
                      final snackbar = SnackBar(
                        content: Text('Upload Image'),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },
                  child: Text('Submit')),
              ElevatedButton(
                  onPressed: () async {
                    List<InputField> list = <InputField>[];
                    if (image || _formKey.currentState.validate()) {
                      _formKey.currentState.save();

//                      InputField obj = new InputField(
//                        name: 'abhjsi',
//                        item_name: 'jsch',
//                        grosswt: 55.00,
//                        netwt: 56.00,
//                        purity: '999',
//                        certificate_no: 12345,
//                        img: _image,
//                        huid: 'huid',
//                      );
                      InputField obj = new InputField(
                        name: _formKey.currentState.value['name'],
                        item_name: _formKey.currentState.value['item_name'],
                        grosswt: double.parse(
                            _formKey.currentState.value['grosswt']),
                        netwt:
                            double.parse(_formKey.currentState.value['netwt']),
                        purity: _formKey.currentState.value['purity'],
                        certificate_no: int.parse(
                            _formKey.currentState.value['certificate_no']),
                        img: _image,
                        huid: _formKey.currentState.value['huid'],
                      );
                      list.add(obj);

                      var pdflist = await Navigator.pushNamed(
                          context, PdfGenerator.routeName,
                          arguments: list);
                    } else {
                      final snackbar = SnackBar(
                        content: Text('Upload Image'),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },
                  child: Text('Generate PDF')),
            ],
          ),
        ),
      ),
    );
  }
}
