import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white24,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: TextField(
          decoration: InputDecoration(
              focusColor: Colors.black,
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
                borderRadius: BorderRadius.circular(10),
              )),
        ),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0,
          ),
          Center(child: Image.asset('assets/sun.png')),
          SizedBox(
            height: 40,
          ),
          Text(
            '23°C',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // Row(
          //   children: [
          //     SizedBox(
          //         height: 20,
          //         child: Image.asset(
          //           'assets/water.png',
          //           color: Colors.white,
          //         )),
          //     SizedBox(height: 20, child: Image.asset('assets/wind.png'))
          //   ],
          // ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Humidity',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Text('Wind Speed',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('30%',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
                Text('30km/s',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600))
              ],
            ),
          )
        ],
      ),
    );
  }
}
