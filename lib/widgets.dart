
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:urine/main.dart';
import 'package:urine/model/urine_model.dart';
import 'package:urine/utils/color.dart';
import 'package:urine/utils/etc.dart';
import 'package:urine/utils/frame.dart';

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap})
      : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            result.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(result.rssi.toString()),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
        ),
        onPressed: (result.advertisementData.connectable) ? onTap : null,
        child:  const Text('CONNECT'),
      ),
      children: <Widget>[
        _buildAdvRow(
            context, 'Complete Local Name', result.advertisementData.localName),
        _buildAdvRow(context, 'Tx Power Level',
            '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(context, 'Manufacturer Data',
            getNiceManufacturerData(result.advertisementData.manufacturerData)),
        _buildAdvRow(
            context,
            'Service UUIDs',
            (result.advertisementData.serviceUuids.isNotEmpty)
                ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
                : 'N/A'),
        _buildAdvRow(context, 'Service Data',
            getNiceServiceData(result.advertisementData.serviceData)),
      ],
    );
  }
}

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile(
      {Key? key, required this.service, required this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.isNotEmpty) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Service'),
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Theme.of(context).textTheme.caption?.color))
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
        title: const Text('Service'),
        subtitle:
        Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}

class CharacteristicTile extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;
  final VoidCallback? onNotificationPressed;

  const CharacteristicTile({Key? key,
        required this.characteristic,
        required this.descriptorTiles,
        this.onReadPressed,
        this.onWritePressed,
        this.onNotificationPressed})
      : super(key: key);

  @override
  State<CharacteristicTile> createState() => _CharacteristicTileState();
}

class _CharacteristicTileState extends State<CharacteristicTile> {

  StringBuffer sb = new StringBuffer('');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.characteristic.onValueChangedStream.listen((value) {

      // 버퍼에 수신된 데이터를 쌓는다.
      sb.write((String.fromCharCodes(value)).replaceAll('\n', ''));

      // 마지막 비타민 결과 데이터가 들어왔는지 확인한다.
      // 이후 파싱
      if (sb.toString().contains('#A11')) {
        mLog.d('replaceAll: ${sb.toString().replaceAll('\n', '')}');
        UrineModel urineModel = UrineModel();
        urineModel.initialization(sb.toString());
      };

    });


  }
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<int>>(
      stream: widget.characteristic.value,
      initialData: widget.characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${widget.characteristic.serviceUuid}'),
                Text('read: ${widget.characteristic.properties.read.toString()}\n'
                    'write: ${widget.characteristic.properties.write.toString()}\n'
                    ,textScaleFactor: 0.7,style: const TextStyle(color: Colors.blueAccent),
                ),
                Text(
                    '0x${widget.characteristic.uuid.toString().toUpperCase().substring(4, 8)}',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).textTheme.caption?.color))
              ],
            ),
            subtitle: Text(value.toString()),
            contentPadding: const EdgeInsets.all(0.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.file_download,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                ),
                onPressed: widget.onReadPressed,
              ),
              IconButton(
                icon: Icon(Icons.file_upload,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: widget.onWritePressed,
              ),
              IconButton(
                icon: Icon(
                    widget.characteristic.isNotifying
                        ? Icons.sync_disabled
                        : Icons.sync,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: widget.onNotificationPressed,
              )
            ],
          ),
          children: widget.descriptorTiles,
        );
      },
    );
  }
}

class DescriptorTile extends StatelessWidget {
  final BluetoothDescriptor descriptor;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;

  const DescriptorTile(
      {Key? key,
        required this.descriptor,
        this.onReadPressed,
        this.onWritePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Descriptor'),
          Text('0x${descriptor.uuid.toString().toUpperCase().substring(4, 8)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Theme.of(context).textTheme.caption?.color))
        ],
      ),
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.value,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) => Text(snapshot.data.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onReadPressed,
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onWritePressed,
          )
        ],
      ),
    );
  }
}


class EmptyView extends StatelessWidget {
  final String text;

  const EmptyView({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Image.asset('images/empty_image.png'),
            SizedBox(height: 15),
            Frame.myText(text: text, fontSize: 1.3, color: mainColor, fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}


class GroupListHeader extends StatelessWidget {
  final String headerText;

  const GroupListHeader({Key? key, required this.headerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 28,
      margin: EdgeInsets.only(left: width / 2.65, right: width / 2.65, top: 20, bottom: 5),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month_sharp, size: 20, color: mainColor),
          SizedBox(width: 10),
          Frame.myText(
              text: Etc.setGroupDateTime(headerText),
              color: Colors.black,
              fontWeight: FontWeight.w600,
              maxLinesCount: 1,
              fontSize: 0.8,
              align: TextAlign.center),
        ],
      ),
    );
  }
}
class ViewVitamin extends StatelessWidget {
  final double width;
  const ViewVitamin({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          children:
          [
            Container(
              child: Row(
                children: [
                  Icon(Icons.feed_outlined),
                  SizedBox(width: 10),
                  Frame.myText(
                    text: '건강예찰',
                    fontSize: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            buildColumn(context, width, '비타민', '비타민은 에너지는 내지 않지만 신체기능 조절에 있어서 필수적인 영양소입니다. 하루에 필요한 비타민 양은 탄수화물, 단백질, 지질에 비하여 극히 적습니다.'),
            buildColumn(context, width, '예상 질병','야맹증, 안구건조증, 피로함, 소화장애, 코피, 치통,골다공증, 노화, 비만 등 '),
            buildColumn(context, width, '예상 증상', '두통, 입술 갈라짐, 가늘어진 모발, 혀 궤양, 불안증 비듬, 건선 등이 나타날 수 있다.'),
            buildColumn(context, width, '식이요법', '짙은 녹색 잎이 많은 채소, 살코기, 닭고기, 생선 등이 있으며 철분이 잘 흡수 되도록 비타민C 음식과 함께 섭취하면 좋습니다. 칼슘은 뼈와 치아를 튼튼하게 하고 근육 기능을 돕습니다. 칼슘은 뼈 건강에 필수이기 때문에 골다공증 등 여성에게 최고의 비타민 중 하나입니다.'),
            buildColumn(context, width, '운동 가이드', '걷기는 어디서나 할 수 있고 장비가 필요 없으며 관절에 무리가 가지 않으며 남녀노소 어느 누구나 할 수 있는 훌륭한 운동입니다. 일상생활에 더 많은 산책을 해보세요.'),
          ]
      ),
    );;
  }

  buildColumn( BuildContext context, double width, String headText, String mainText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Frame.myText(
              text: '✓ $headText',
              color: mainColor,
              fontSize: 1.2,
              fontWeight: FontWeight.w600,
              align: TextAlign.start),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10),
          width: width - 110,
          child: Frame.myText(text: mainText, maxLinesCount: 4),
        ),

        Etc.solidLineSetting(context),
      ],
    );
  }
}

class HighLightedText extends StatelessWidget {
  final String data;
  final Color highLightColor;
  final Color fontColor;
  final double fontSize;

  const HighLightedText(
      this.data, {
        super.key,
        required this.highLightColor,
        required this.fontColor,
        this.fontSize = 14,
      });

  Size getTextSize({
    required String text,
    required TextStyle style,
    required BuildContext context,
  }) {
    final Size size = (TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;
    return size;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontSize: fontSize,
      color: fontColor,
      fontWeight: FontWeight.bold,
    );
    final Size textSize = getTextSize(
      text: data,
      style: textStyle,
      context: context,
    );
    return Stack(
      children: [
        Frame.myText(
            text: data,
            fontSize: 1.1,
            maxLinesCount: 30,
            fontWeight: FontWeight.w600,
            align: TextAlign.start),

        Positioned(
          top: textSize.height / 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: highLightColor.withOpacity(0.3),
            ),
            height: textSize.height / 3,
            width: textSize.width,
          ),
        )
      ],
    );
  }
}





// class AdapterStateTile extends StatelessWidget {
//   const AdapterStateTile({Key? key, required this.state}) : super(key: key);
//
//   final BluetoothState state;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.redAccent,
//       child: ListTile(
//         title: Text(
//           'Bluetooth adapter is ${state.toString().substring(15)}',
//           style: Theme.of(context).primaryTextTheme.subtitle2,
//         ),
//         trailing: Icon(
//           Icons.error,
//           color: Theme.of(context).primaryTextTheme.subtitle2?.color,
//         ),
//       ),
//     );
//   }
// }

