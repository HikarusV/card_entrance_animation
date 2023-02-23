import 'package:flutter/material.dart';

import 'card.dart';
import 'card_model.dart';

class TestAnim extends StatefulWidget {
  const TestAnim({Key? key}) : super(key: key);

  @override
  State<TestAnim> createState() => _TestAnimState();
}

class _TestAnimState extends State<TestAnim> with TickerProviderStateMixin {
  List<FlightStopTicket> stops = [
    FlightStopTicket("Sahara", "SHE", "Macao", "MAC", "SE2341"),
    FlightStopTicket("Macao", "MAC", "Cape Verde", "CAP", "KU2342"),
    FlightStopTicket("Cape Verde", "CAP", "Ireland", "IRE", "KR3452"),
    FlightStopTicket("Ireland", "IRE", "Sahara", "SHE", "MR4321"),
  ];

  late AnimationController cardEntranceAnimationController;
  late List<Animation> ticketAnimations;
  late Animation fabAnimation;

  @override
  void initState() {
    super.initState();
    cardEntranceAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    ticketAnimations = stops.map((stop) {
      int index = stops.indexOf(stop);
      double start = index * 0.1;
      double duration = 0.6;
      double end = duration + start;
      return Tween<double>(begin: 800.0, end: 0.0).animate(CurvedAnimation(
          parent: cardEntranceAnimationController,
          curve: Interval(start, end, curve: Curves.decelerate)));
    }).toList();
    fabAnimation = CurvedAnimation(
        parent: cardEntranceAnimationController,
        curve: const Interval(0.7, 1.0, curve: Curves.decelerate));
    cardEntranceAnimationController.forward();
  }

  @override
  void dispose() {
    cardEntranceAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Animation'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: SingleChildScrollView(
            child: Column(
              children: _buildTickets().toList(),
            ),
          )),
        ],
      ),
    );
  }

  Iterable<Widget> _buildTickets() {
    return stops.map((stop) {
      int index = stops.indexOf(stop);
      return AnimatedBuilder(
        animation: cardEntranceAnimationController,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: TicketCard(stop: stop),
        ),
        builder: (context, child) => Transform.translate(
          offset: Offset(0.0, ticketAnimations[index].value),
          child: child,
        ),
      );
    });
  }
}
