
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

      // ????????? ????????? ???????????? ?????????.
      sb.write((String.fromCharCodes(value)).replaceAll('\n', ''));

      // ????????? ????????? ?????? ???????????? ??????????????? ????????????.
      // ?????? ??????
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
                    text: '????????????',
                    fontSize: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            buildColumn(context, width, '?????????', '???????????? ???????????? ?????? ????????? ???????????? ????????? ????????? ???????????? ??????????????????. ????????? ????????? ????????? ?????? ????????????, ?????????, ????????? ????????? ?????? ????????????.'),
            buildColumn(context, width, '?????? ??????','?????????, ???????????????, ?????????, ????????????, ??????, ??????,????????????, ??????, ?????? ??? '),
            buildColumn(context, width, '?????? ??????', '??????, ?????? ?????????, ???????????? ??????, ??? ??????, ????????? ??????, ?????? ?????? ????????? ??? ??????.'),
            buildColumn(context, width, '????????????', '?????? ?????? ?????? ?????? ??????, ?????????, ?????????, ?????? ?????? ????????? ????????? ??? ?????? ????????? ?????????C ????????? ?????? ???????????? ????????????. ????????? ?????? ????????? ???????????? ?????? ?????? ????????? ????????????. ????????? ??? ????????? ???????????? ????????? ???????????? ??? ???????????? ????????? ????????? ??? ???????????????.'),
            buildColumn(context, width, '?????? ?????????', '????????? ???????????? ??? ??? ?????? ????????? ?????? ????????? ????????? ????????? ?????? ????????? ???????????? ?????? ????????? ??? ??? ?????? ????????? ???????????????. ??????????????? ??? ?????? ????????? ????????????.'),
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
              text: '??? $headText',
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

