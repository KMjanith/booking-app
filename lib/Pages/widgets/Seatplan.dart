import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ColoredGridView extends StatefulWidget {
  final int maxSeatCount;
  final int seetCount;
  final List<int> gridData;
  ColoredGridView(
      {super.key,
      required this.seetCount,
      required this.gridData,
      required this.maxSeatCount});

  @override
  _ColoredGridViewState createState() => _ColoredGridViewState();
}

class _ColoredGridViewState extends State<ColoredGridView> {
  int passengerCountSelector =
      1; //to making a count to compare with the maximum seat can select

  void _toggleCell(int index, List<int> gridData) {
    setState(() {
      //print(gridData[index]);
      if (gridData[index] == 0) {
        if (passengerCountSelector > widget.maxSeatCount ) {
          
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text:
                'You have selected the seats\nbeyond the passenger limit.\nYou can select only ${widget.maxSeatCount} seats only',
          );
        
        } else {
          gridData[index] = 2;
          passengerCountSelector = passengerCountSelector + 1;
          //print("selectedseats $passengerCountSelector");
        }
      } // Toggle between 0 and 1
      else if (gridData[index] == 2) {
        gridData[index] = 0;
        passengerCountSelector = passengerCountSelector - 1;
        //print("selectedseats $passengerCountSelector");
      } else {
        gridData[index] = gridData[index];
      }
      //print("selectedseats $passengerCountSelector");
    });
  }

  Color getCellColor(int data) {
    if (data == 1) {
      return const Color.fromARGB(255, 238, 21, 5); // Green
    } else if (data == 2) {
      return Colors.orange; // Orange
    } else {
      return const Color.fromARGB(255, 72, 199, 47); // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, //grid number
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: widget.seetCount,
      itemBuilder: (context, index) {
        Color cellColor = getCellColor(widget.gridData[index]);
        return Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
          height: 10,
          width: 10,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 12, 192, 123),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: GestureDetector(
            onTap: () {
              //print(index);
              _toggleCell(index, widget.gridData);
              //print(widget.gridData);
            },
            child: Container(
              color: cellColor,
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
