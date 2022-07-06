//import 'package:flutter/material.dart';
import 'package:hallmarkcardgenerator/Model/InputFields.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';

pw.Widget header1() {
  return pw.Container(
      child: pw.Text(
    'DEMO  HALLMARKING  CARD',
    maxLines: 1,
    style: pw.TextStyle(
        font: pw.Font.helveticaBold(),
        fontSize: 13,
        color: PdfColors.red900,
        fontWeight: pw.FontWeight.bold),
  ));
}

pw.Widget header2(pw.ImageProvider logoImage) {
  return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: <pw.Widget>[
        pw.Container(
          child: pw.Image(
            logoImage,
            width: 1.1 * PdfPageFormat.cm,
            height: 0.7 * PdfPageFormat.cm,
            fit: pw.BoxFit.fill,
          ),
          margin: pw.EdgeInsets.fromLTRB(6, 4, 1, 1),
        ),
        pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: <pw.Widget>[
              pw.SizedBox(height: 1),
              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                        text: '      This a Demo Application for Card Genrator',
//                            '      BIS Approved Assaying and Hallmarking Centre',
                        style: pw.TextStyle(
                          color: PdfColors.blue900,
                          fontSize: 7.0,
                          fontWeight: pw.FontWeight.bold,
                          //font: pw.Font.timesBoldItalic(),
                        ),
                      ))),
              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.RichText(
                      textAlign: pw.TextAlign.left,
                      text: pw.TextSpan(
                          text: 'Ward No.41,Infront Of Lal Bihari Market',
                          style: pw.TextStyle(
                            color: PdfColors.blue900,
                            fontSize: 7.0,
                            fontWeight: pw.FontWeight.bold,

                            //fontBoldItalic: pw.Font.timesBoldItalic(),
                          ),
                          children: <pw.InlineSpan>[
                            pw.TextSpan(
                              text: 'Tel. 2508852',
                              style: pw.TextStyle(
                                color: PdfColors.blue900,
                                fontSize: 7,
                                // fontWeight: pw.FontWeight.bold,

                                //    font: pw.Font.timesItalic()
                              ),
                            ),
                          ]))),
            ])
      ]);
}

pw.Widget divider() {
  return pw.Container(
    //color: PdfColorCmyk(0, 0.81, 0.81, 0.26),
    color: PdfColors.red900,
    padding: pw.EdgeInsets.only(bottom: 1),
    margin: pw.EdgeInsets.only(bottom: 3),
    child: pw.Text('XRF GOLD TESTING CERTIFICATE',
        style: pw.TextStyle(
          color: PdfColors.white,
          decorationThickness: 2,
          //height: 0.22 * PdfPageFormat.cm,
          fontSize: 6,
          fontWeight: pw.FontWeight.bold,
        )),
    alignment: pw.Alignment.center,
    height: 0.24 * PdfPageFormat.cm,
    width: 8.57 * PdfPageFormat.cm,
  );
}

pw.Widget card(InputField args, pw.ImageProvider logoImage) {
  final photo = pw.MemoryImage(
    args.img,
  );
  return pw.Container(
    decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(10),
        // color: PdfColors.white,
        border: pw.Border.all()),
    width: 3.375 * PdfPageFormat.inch,
    height: 2.125 * PdfPageFormat.inch,
    child: pw.Column(children: <pw.Widget>[
      header1(),
      header2(logoImage),
      divider(),
      pw.Container(
        alignment: pw.Alignment.centerLeft,
        margin: pw.EdgeInsets.fromLTRB(12, 0, 3, 0),
        child: pw.Text('Name               :${args.name}',
            textAlign: pw.TextAlign.left,
            style: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold)),
      ),
      pw.Container(
        alignment: pw.Alignment.centerLeft,
        margin: pw.EdgeInsets.fromLTRB(12, 0, 3, 0),
        child: pw.Text('Item Name      :${args.item_name}',
            textAlign: pw.TextAlign.left,
            style: pw.TextStyle(
                color: PdfColors.black,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold)),
      ),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        //mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <pw.Widget>[
          pw.Padding(padding: pw.EdgeInsets.all(6)),
          pw.Expanded(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.max,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Text('Gross Wt.       :${args.grosswt}',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold)),
                pw.Text('Net Wt.            :${args.netwt}',
                    textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold)),
                pw.Text('Purity              :${args.purity}',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold)),
                pw.Text('Remark           :${args.remark}',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold)),
                pw.Text('Certificate No :${args.certificate_no}',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold)),
                pw.Text('HUID No :${args.huid}',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),
          pw.Container(
            constraints: pw.BoxConstraints(
                maxWidth: 2.8 * PdfPageFormat.cm,
                maxHeight: 2.5 * PdfPageFormat.cm,
                minHeight: 2.4 * PdfPageFormat.cm,
                minWidth: 2.7 * PdfPageFormat.cm),
//                      width: 2.8 * PdfPageFormat.cm,
//                      height: 2.5 * PdfPageFormat.cm,
            //color: PdfColors.amber800,
            padding: pw.EdgeInsets.fromLTRB(0, 0, 0.1 * PdfPageFormat.cm, 0),
            //alignment: pw.Alignment.bottomRight,
            child: pw.Image(photo,
                width: 2.8 * PdfPageFormat.cm,
                height: 2.5 * PdfPageFormat.cm,
                fit: pw.BoxFit.fitWidth),
            //right: 0.1 * PdfPageFormat.cm,
            //bottom: 0.5 * PdfPageFormat.cm,
            //top: 20,
          ),
          pw.SizedBox(
              width: 0.1 * PdfPageFormat.cm, height: 2.5 * PdfPageFormat.cm),
        ],
      ),
    ]),
  );
}

class PdfGenerator extends StatelessWidget {
  static const routeName = '/PdfGenerator';

  Future<List<String>> getattachment(List<InputField> args) async {
    File file;
    PdfPageFormat format = PdfPageFormat.a4;
    int len = args.length;
    List<String> cardfile = [];
    var output = await getTemporaryDirectory();
    var dir = await output.createTemp('hallmark');
    if (len.isEven) {
      for (int i = 0; i < len; i = i + 2) {
        file = File('${dir.path}/hm${args[i].id}_${args[i + 1].id}.pdf');
        await file
            .writeAsBytes(await _twocardGenerate(format, args.sublist(i)));
        cardfile.add(file.path);
      }
    }
    if (len.isOdd) {
      for (int i = 0; i < len - 1; i = i + 2) {
        file = File('${dir.path}/hm${args[i].id}_${args[i + 1].id}.pdf');
        await file
            .writeAsBytes(await _twocardGenerate(format, args.sublist(i)));
        cardfile.add(file.path);
      }
      //final output = await getTemporaryDirectory();
      //file.deleteSync();
      //ImageHelper imh =ImageHelper();

      file = File('${dir.path}/hm${args.last.id}.pdf');
      await file.writeAsBytes(await _singlecardGenerate(format, args));
      cardfile.add(file.path);
      //print(cardfile.first);
      //print(await output.exists());
      //print(await dir.exists());

      // print(dir.path);

      //  imh.saveImage(args.last.certicate_no.toString(), file.path.toString());
      await for (var entity in dir.list(recursive: true, followLinks: false)) {
        print(entity.path);
      }
      // await dir.delete(recursive: true);
      print(await output.exists());
      print(await dir.exists());
      await for (var entity
          in output.list(recursive: false, followLinks: false)) {
        print(entity.path);
      }
    }

    //  Navigator.pop(context,cardfile);
    return cardfile;
  }

  Future<Uint8List> _singlecardGenerate(
      PdfPageFormat format, List<InputField> list) async {
    final pdf = pw.Document();
    final logoImage = await imageFromAssetBundle('images/hs1.png');
    pdf.addPage(
      pw.Page(
          pageTheme: pw.PageTheme(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.fromLTRB(
                1.2563 * PdfPageFormat.inch, 0.4479 * PdfPageFormat.inch, 0, 0),
          ),
          build: (pw.Context context) {
            return pw.Column(
              children: <pw.Widget>[
                card(list[0], logoImage),
              ],
            );
          }),
    );
    return pdf.save();
  }

  Future<Uint8List> _twocardGenerate(
      PdfPageFormat format, List<InputField> list) async {
    final pdf = pw.Document(
      compress: false,
      title: '${list[0].certificate_no}-${list[1].certificate_no}',
      author: 'hallmarkgenerator',
    );

    final logoImage = await imageFromAssetBundle('images/hs1.png');
    final photo = pw.MemoryImage(
      (await rootBundle.load('images/ring.jpg')).buffer.asUint8List(),
    );
    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.fromLTRB(1.2563 * PdfPageFormat.inch,
                0.4479 * PdfPageFormat.inch, 0, 0)),
        //pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Column(
          children: <pw.Widget>[
            card(list[0], logoImage),
            pw.SizedBox(height: 0.2431 * PdfPageFormat.inch),
            card(list[1], logoImage),
          ],
        ),
      ),
    );
    return pdf.save();
  }

  Future<Uint8List> multicard(
      PdfPageFormat format, List<InputField> list) async {
    final pdf = pw.Document(
      compress: false,
      title: '${list[0].id}-${list[1].id}',
      author: 'hallmarkgenerator',
    );
    final logoImage = await imageFromAssetBundle('images/bis.png');
    int len = list.length;
    if (len.isEven) {
      for (int i = 0; i < len; i = i + 2) {
        pdf.addPage(
          pw.Page(
            pageTheme: pw.PageTheme(
                pageFormat: PdfPageFormat.a4,
                margin: pw.EdgeInsets.fromLTRB(1.2563 * PdfPageFormat.inch,
                    0.4479 * PdfPageFormat.inch, 0, 0)),
            //pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) => pw.Column(
              children: <pw.Widget>[
                card(list[i], logoImage),
                pw.SizedBox(height: 0.2431 * PdfPageFormat.inch),
                card(list[i + 1], logoImage),
              ],
            ),
          ),
        );
      }
    } else if (len.isOdd) {
      for (int i = 0; i < len - 1; i = i + 2) {
        pdf.addPage(
          pw.Page(
            pageTheme: pw.PageTheme(
                pageFormat: PdfPageFormat.a4,
                margin: pw.EdgeInsets.fromLTRB(1.2563 * PdfPageFormat.inch,
                    0.4479 * PdfPageFormat.inch, 0, 0)),
            //pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) => pw.Column(
              children: <pw.Widget>[
                card(list[i], logoImage),
                pw.SizedBox(height: 0.2431 * PdfPageFormat.inch),
                card(list[i + 1], logoImage),
              ],
            ),
          ),
        );
      }
      pdf.addPage(
        pw.Page(
            pageTheme: pw.PageTheme(
              pageFormat: PdfPageFormat.a4,
              margin: pw.EdgeInsets.fromLTRB(1.2563 * PdfPageFormat.inch,
                  0.4479 * PdfPageFormat.inch, 0, 0),
            ),
            build: (pw.Context context) {
              return pw.Column(
                children: <pw.Widget>[
                  card(list[len - 1], logoImage),
                ],
              );
            }),
      );
    }
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List<InputField>;
    int len = args.length;
    if (len > 2) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Pdf Viewer'),
          centerTitle: true,
        ),
        body: PdfPreview(
          build: (format) async {
            Uint8List show;

            show = await multicard(format, args);

            return show;
          },
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Pdf Viewer'),
          centerTitle: true,
        ),
        body: PdfPreview(
          build: (format) async {
            Uint8List show;
            if (len == 1) {
              show = await _singlecardGenerate(format, args);
            } else if (len == 2) {
              show = await _twocardGenerate(format, args);
            }
            return show;
          },
        ),
      );
    }
    //  Navigator.pop(context, 'Nope.');
  }
}

//card container rough data with widget


