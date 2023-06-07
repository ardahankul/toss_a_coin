import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CoinFlipApp());
}

class CoinFlipApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1 Lira',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CoinFlipScreen(),
    );
  }
}

class CoinFlipScreen extends StatefulWidget {
  @override
  _CoinFlipScreenState createState() => _CoinFlipScreenState();
}

class _CoinFlipScreenState extends State<CoinFlipScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late bool _isHeads = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {
          _isHeads = Random().nextBool();
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isHeads = Random().nextBool();
          });
          _animationController.reverse();
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flipCoin() {
    if (_animationController.isAnimating) {
      return;
    }

    setState(() {
      _isHeads = Random().nextBool();
    });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text(
           'Yazı Tura',
            style: TextStyle(
              color: Colors.white
            ),
       ),
        backgroundColor: Colors.black,
      ),
      body: GestureDetector(
        onTap: _flipCoin,
        child: Center(
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_animation.value * pi),
            alignment: Alignment.center,
            child: Image.asset(
              _isHeads ? 'assets/heads.png' : 'assets/tails.png',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}