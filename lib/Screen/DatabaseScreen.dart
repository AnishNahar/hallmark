import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:hallmarkcardgenerator/Model/InputFields.dart';
import 'package:hallmarkcardgenerator/PdfGenerator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hallmarkcardgenerator/Model/Helper.dart';
import 'FormScreen.dart';
//import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';
import 'package:hallmarkcardgenerator/Screen/EditFormScreen.dart';
import 'package:hallmarkcardgenerator/objectbox.g.dart';

class DatabaseScreen extends StatefulWidget {
  static const routeName = '/Database';
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  //static const routeName = '/Database';
  bool selectionmode = false;
  Set<InputField> selectedItem = {};
  Set<int> selectedItemIndex = {};
  ViewModel _vm;
  Set<InputField> allItem = {};
  bool isDbOpen = false;

  @override
  void initState() {
    super.initState();

    openStore().then((Store store) {
      _vm = ViewModel(store);
      isDbOpen = true;
      print('Database Screen Init ,is dbopen${isDbOpen}');
      setState(() {
        allItem.clear();
        allItem.addAll(_vm.allItem());
      });
    });
  }

  @override
  void dispose() {
    print('Database Screen dispose ,is dbopen${isDbOpen}');
    if (isDbOpen) {
      _vm.dispose();
      isDbOpen = false;
    }
    print('Database Screen dispose ,is dbopen${isDbOpen}');
    super.dispose();
  }

  Widget listWidget(InputField inf) {
    return Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5), border: Border.all()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // constraints: BoxConstraints(),
            margin: EdgeInsets.only(left: 7),
            width: 90,
            height: 90,
            child: Image.memory(inf.img),
          ),
          SizedBox(
            width: 20,
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Id : ${inf.id.toString()}'),
              Text('Name :${inf.name}'),
              Text('Item Name : ${inf.item_name}'),
              Text('Ctfe No :${inf.certificate_no.toString()}'),
              Text('Wt : ${inf.id.toString()}'),
              // Divider(thickness: 90,color: Colors.yellow,height: 40,indent: 9,),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Databsze build method before return');
    return Scaffold(
      appBar: AppBar(
        leading: selectionmode
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selectionmode = false;
                    selectedItem.clear();
                    selectedItemIndex.clear();
                  });
                },
              )
            : null,
        title: (!selectionmode)
            ? Text('Database')
            : Text(
                '${selectedItem.length} item selected',
              ),
        actions: [
          selectionmode
              ? Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Icon(
                      Icons.delete,
                      size: 26.0,
                    ),
                    onTap: () async {
                      _vm.removeManyCard(selectedItemIndex.toList());
                      setState(() {
                        //TODO remove only thos item which are selected and not all th items
                        allItem = (allItem.difference(selectedItem));
                        selectedItem.clear();
                        selectedItemIndex.clear();
                        selectionmode = false;
                      });
                    },
                  ),
                )
              : Container(),
          selectionmode
              ? Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              child: Icon(
                Icons.email_rounded,
                size: 26.0,
              ),
              onTap: () async {
                //Directory dir = await getTemporaryDirectory();
                List<String> attachment = await PdfGenerator()
                    .getattachment(selectedItem.toList());

                EmailPdf emailpdf = EmailPdf();
                // print(dir.path);

                await emailpdf.send(context, attachment);
                if (attachment.isNotEmpty) {
                  Directory output = Directory(attachment[0]).parent;
                  print(output.path);
                  await for (var entity in output.list(
                      recursive: true, followLinks: false)) {
                    print(entity.path);
                  }
                  output.deleteSync(recursive: true);
                  var dir = await getTemporaryDirectory();
                  await for (var entity
                  in dir.list(recursive: true, followLinks: false)) {
                    print(entity.path);
                  }
                  print(dir.exists());
                  dir.deleteSync(recursive: true);
                  print(dir.exists());
                }
              },
            ),
          )
              : Container(),
          selectionmode
              ? Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Icon(
                      Icons.picture_as_pdf,
                      size: 26.0,
                    ),
                    onTap: () async {
                      Navigator.pushNamed(context, PdfGenerator.routeName,
                          arguments: selectedItem.toList());
                      setState(() {
                        selectionmode = false;
                        selectedItem.clear();
                        selectedItemIndex.clear();
                      });
                    },
                  ),
                )
              : Container(),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(
//          Icons.add,
//        ),
//        onPressed: () async {
//          InFwS infws = InFwS(inputField: null, vm: _vm);
//
//          var result = await Navigator.pushNamed(
//              context, EditFormScreen.routeName,
//              arguments: infws);
//          if (result != null) {
//            setState(() {
//              allItem.add(result);
//            });
//          }
//        },
//      ),
      body: Center(
          child: allItem.isNotEmpty
              ? ListView.builder(
                  itemCount: allItem.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      selected: selectedItem.contains(allItem.elementAt(index)),
                      selectedTileColor: Colors.yellow,
                      title: listWidget(allItem.elementAt(index)),
                      onTap: () async {
                        if (selectionmode) {
                          setState(() {
                            if (selectedItemIndex
                                .contains(allItem.elementAt(index).id)) {
                              selectedItem.remove(allItem.elementAt(index));
                              selectedItemIndex
                                  .remove(allItem.elementAt(index).id);
                            } else {
                              selectedItem.add(allItem.elementAt(index));
                              selectedItemIndex
                                  .add(allItem.elementAt(index).id);
                            }
                          });
                        } else {
                          print('Database Screen ontab ,is dbopen${isDbOpen}');
                          InputField arg = allItem.elementAt(index);
                          InFwS infws = InFwS(inputField: arg, vm: _vm);
                          var result = await Navigator.pushNamed(
                              context, EditFormScreen.routeName,
                              arguments: infws);
                          if (result != null) {
                            setState(() {
                              allItem.remove(arg);
                              allItem.add(result);
                            });
                          }
                        }
                      },
                      onLongPress: () {
                        setState(() {
                          selectionmode = !selectionmode;
                          if (!selectionmode) {
                            selectedItem.clear();
                            selectedItemIndex.clear();
                          } else {
                            selectedItemIndex.add(allItem.elementAt(index).id);
                            selectedItem.add(allItem.elementAt(index));
                          }
                        });
                      },
                    );
                  })
              : Center(
                  child: Text('Create a Card in Form '),
                )),
    );
  }
}

class EmailPdf {
  Future<void> send(BuildContext context, List<String> attachment) async {
    //  var store=await ObjectBoxStore.getStore();
    if (Platform.isIOS) {
      final bool canSend = await FlutterMailer.canSendMail();
      if (!canSend) {
        const SnackBar snackbar =
            const SnackBar(content: Text('no Email App Available'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }
    }

    // Platform messages may fail, so we use a try/catch PlatformException.
    final MailOptions mailOptions = MailOptions(
      body: 'Test',
      subject: 'PDF',
      recipients: <String>['abhishekbhandari2000.ab@gmail.com'],
      isHTML: false,
      // bccRecipients: ['other@example.com'],
      //ccRecipients: <String>['third@example.com'],
      attachments: attachment,
    );

    String platformResponse;

    try {
      final MailerResponse response = await FlutterMailer.send(mailOptions);
      switch (response) {
        case MailerResponse.saved:
          platformResponse = 'mail saved to draft';
          break;
        case MailerResponse.sent:
          platformResponse = 'mail  sent';
          break;
        case MailerResponse.cancelled:
          platformResponse = 'mail was cancelled';
          break;
        case MailerResponse.android:
          platformResponse = 'intent was success';
          break;
        default:
          platformResponse = 'unknown';
          break;
      }
    } on PlatformException catch (error) {
      platformResponse = error.toString();
      print(error);
//      if (!mounted) {
//        return;
//      }
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Message',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(error.message ?? 'unknown error'),
            ],
          ),
          contentPadding: const EdgeInsets.all(26),
          title: Text(error.code),
        ),
      );
    } catch (error) {
      platformResponse = error.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
//    if (!mounted) {
//      return;
//    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(platformResponse),
      duration: Duration(seconds: 4),
    ));
  }
}
