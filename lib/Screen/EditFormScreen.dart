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

class InFwS {
  InputField inputField;
  ViewModel vm;
  InFwS({this.inputField, this.vm});
}

class EditFormScreen extends StatefulWidget {
  static const routeName = '/EditForm';

  @override
  _EditFormScreenState createState() => _EditFormScreenState();
}

class _EditFormScreenState extends State<EditFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Uint8List _image;
  ImageHelper imh = ImageHelper();
  ViewModel _vm;
  bool isDbOpen = false;
  bool image = false;

  @override
  void initState() {
    super.initState();
    print('form Screen Init ,');
  }

  @override
  void dispose() {
    print('form Screen dispose ,');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('form Screen build before ModelRoute ,');
    var argument = ModalRoute.of(context).settings.arguments as InFwS;
    print('form Screen after Model Route ');
    InputField args = argument.inputField;
    setState(() {
      _vm = argument.vm;
    });
    if (args != null) {
      setState(() {
        _image = args.img;
        image = true;
      });
    } else {
      args = InputField(
        name: '',
        item_name: '',
        grosswt: 0,
        netwt: 0,
        purity: '',
        certificate_no: 0,
        huid:''
      );
      setState(() {
        image = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Form Page'),
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
                      initialValue: args.name,
                      name: 'name',
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                      ]),
                      onTap: () {
                        print('form Screen Name Field is Tapped ,');
                      },
                    ),
                    FormBuilderTextField(
                      initialValue: args.item_name,
                      name: 'item_name',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                      ]),
                      decoration: InputDecoration(labelText: 'Item Name'),
                    ),
                    FormBuilderTextField(
                      name: 'grosswt',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                        FormBuilderValidators.numeric(context,
                            errorText: 'Enter a Number only'),
                      ]),
                      initialValue: args.grosswt.toString(),
                      decoration: InputDecoration(labelText: 'Gross Wt'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                    FormBuilderTextField(
                      name: 'netwt',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                        FormBuilderValidators.numeric(context,
                            errorText: 'Enter a Number only'),
                      ]),
                      initialValue: args.netwt.toString(),
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
                      initialValue: args.purity,
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
                      initialValue: args.remark,
                      decoration: InputDecoration(labelText: 'Remark'),
                    ),
                    FormBuilderTextField(
                      name: 'certificate_no',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                        FormBuilderValidators.numeric(context,
                            errorText: 'Enter a Number only'),
                      ]),
                      initialValue: args.certificate_no.toString(),
                      decoration: InputDecoration(labelText: 'Certificate No'),
                      keyboardType: TextInputType.numberWithOptions(),
                    ),
                    FormBuilderTextField(
                      name: 'huid',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'Mandatory'),
                      ]),
                      initialValue: args.huid.toString(),
                      decoration: InputDecoration(labelText: 'HUID'),
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
                  (!image)
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
                    if (image || _formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      List<InputField> list = <InputField>[];
                      InputField obj = new InputField(
                        id: args.id,
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
                      _vm.updateCard(obj);
                      //_vm.dispose();
                      Navigator.pop(context,obj);
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
                    if (image || _formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      List<InputField> list = <InputField>[];
                      InputField obj = new InputField(
                        id: args.id,
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
