
import 'package:flutter/material.dart';

class Post {
  final String departure;
  final String arrival;
  final String time;
  final bool isRoundTrip;
  final String roundTripTime;
  final String comment;

  Post(this.departure, this.arrival, this.time, this.isRoundTrip, this.roundTripTime, this.comment);
}