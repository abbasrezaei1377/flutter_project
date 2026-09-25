import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ludo Dice',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen>
    with SingleTickerProviderStateMixin {
  int diceNumber = 1;

  final Random random = Random();

  late AnimationController _controller;
  late Animation<double> _animation;

  bool isRolling = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 850),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isRolling = false;
        });

        _controller.reset();
      }
    });
  }

  Future<void> rollDice() async {
    if (isRolling) return;

    setState(() {
      isRolling = true;
    });

    _controller.forward();

    // Change the number while the dice is rolling
    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    if (mounted) {
      setState(() {
        diceNumber = random.nextInt(6) + 1;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B5E20),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Lecture 3 - Ludo Dice',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LUDO DICE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Tap the dice to roll',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 60),

              // CLICK ON THE DICE ITSELF
              GestureDetector(
                onTap: rollDice,

                child: AnimatedBuilder(
                  animation: _animation,

                  builder: (context, child) {
                    final value = _animation.value;

                    return Transform(
                      alignment: Alignment.center,

                      transform: Matrix4.identity()
                        // Perspective for 3D effect
                        ..setEntry(3, 2, 0.0015)

                        // Rotate around X axis
                        ..rotateX(
                          value * pi * 4,
                        )

                        // Rotate around Y axis
                        ..rotateY(
                          value * pi * 6,
                        )

                        // Slight Z rotation
                        ..rotateZ(
                          value * pi * 2,
                        ),

                      child: child,
                    );
                  },

                  child: Dice3D(
                    number: diceNumber,
                  ),
                ),
              ),

              const SizedBox(height: 60),

              AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 300,
                ),
                child: Text(
                  isRolling
                      ? 'Rolling...'
                      : 'You rolled $diceNumber',

                  key: ValueKey(
                    isRolling
                        ? 'rolling'
                        : diceNumber,
                  ),

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.touch_app,
                    color: Colors.white70,
                  ),

                  SizedBox(width: 8),

                  Text(
                    'Tap directly on the dice',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================
// 3D DICE
// ==================================================

class Dice3D extends StatelessWidget {
  final int number;

  const Dice3D({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // RIGHT SIDE OF DICE
        Positioned(
          left: 20,
          top: 18,
          child: Container(
            width: 185,
            height: 185,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),

        // MAIN FRONT FACE
        Container(
          width: 185,
          height: 185,

          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,

              colors: [
                Colors.white,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
            ),

            borderRadius: BorderRadius.circular(30),

            border: Border.all(
              color: Colors.white,
              width: 3,
            ),

            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 20,
                offset: Offset(12, 15),
              ),

              BoxShadow(
                color: Colors.white54,
                blurRadius: 5,
                offset: Offset(-4, -4),
              ),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.all(27),
            child: DiceDots(
              number: number,
            ),
          ),
        ),
      ],
    );
  }
}

// ==================================================
// DICE DOTS
// ==================================================

class DiceDots extends StatelessWidget {
  final int number;

  const DiceDots({
    super.key,
    required this.number,
  });

  Widget dot() {
    return Container(
      width: 27,
      height: 27,

      decoration: const BoxDecoration(
        shape: BoxShape.circle,

        gradient: RadialGradient(
          colors: [
            Color(0xFF555555),
            Colors.black,
          ],
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 4,
            offset: Offset(2, 3),
          ),
        ],
      ),
    );
  }

  Widget empty() {
    return const SizedBox(
      width: 27,
      height: 27,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (number) {
      case 1:
        return Center(
          child: dot(),
        );

      case 2:
        return Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start,
              children: [
                dot(),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                dot(),
              ],
            ),
          ],
        );

      case 3:
        return Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start,
              children: [
                dot(),
              ],
            ),

            Center(
              child: dot(),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                dot(),
              ],
            ),
          ],
        );

      case 4:
        return Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                dot(),
                dot(),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                dot(),
                dot(),
              ],
            ),
          ],
        );

      case 5:
        return Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                dot(),
                dot(),
              ],
            ),

            Center(
              child: dot(),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                dot(),
                dot(),
              ],
            ),
          ],
        );

      case 6:
        return Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                dot(),
                dot(),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                dot(),
                dot(),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                dot(),
                dot(),
              ],
            ),
          ],
        );

      default:
        return Center(
          child: dot(),
        );
    }
  }
}