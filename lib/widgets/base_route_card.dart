// lib/widgets/base_route_card.dart
import 'package:flutter/material.dart';
import '../services/route_service.dart';
import '../map/route_data.dart';

abstract class BaseRouteCard extends StatelessWidget {
  final String routeName;
  final VoidCallback? onTap;

  const BaseRouteCard({
    super.key,
    required this.routeName,
    this.onTap,
  });

  RouteData get routeData => RouteManager.getRoute(routeName)!;
  String get title => routeData.name;
  String get subtitle => RouteService.getRouteSubtitle(routeName);
  String get backgroundImage => routeData.backgroundImage;
  Color get gradientColor => routeData.color;

  @protected
  Widget buildContent(BuildContext context);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: buildContent(context),
    );
  }
}