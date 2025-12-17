import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const AdaptiveScaffold({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 1024;
    
    return Scaffold(
      body: Row(
        children: [
          if (isDesktop) _buildNavigationRail(context),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : _buildBottomNavigationBar(context),
    );
  }

  Widget _buildNavigationRail(BuildContext context) {
    return NavigationRail(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) => _onItemTapped(context, index),
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.library_books),
          label: Text('资源库'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.edit),
          label: Text('编辑器'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.smart_toy),
          label: Text('AI助手'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person),
          label: Text('个人中心'),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) => _onItemTapped(context, index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.library_books),
          label: '资源库',
        ),
        NavigationDestination(
          icon: Icon(Icons.edit),
          label: '编辑器',
        ),
        NavigationDestination(
          icon: Icon(Icons.smart_toy),
          label: 'AI助手',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: '个人中心',
        ),
      ],
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    final router = GoRouter.of(context);
    switch (index) {
      case 0:
        router.go('/library');
        break;
      case 1:
        router.go('/editor');
        break;
      case 2:
        router.go('/ai');
        break;
      case 3:
        router.go('/profile');
        break;
    }
  }
} 