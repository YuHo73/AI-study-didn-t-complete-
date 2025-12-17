import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderables/reorderables.dart';
import '../providers/canvas_provider.dart';
import '../widgets/resource_panel.dart';
import '../widgets/canvas_area.dart';
import '../widgets/property_panel.dart';
import '../widgets/toolbar.dart';

class EditorPage extends ConsumerWidget {
  const EditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    const double sidePanelWidth = 160;

    return Scaffold(
      appBar: isMobile ? AppBar(title: const Text('编辑器')) : null,
      drawer: isMobile
          ? Drawer(
              child: const ResourcePanel(),
            )
          : null,
      endDrawer: isMobile
          ? Drawer(
              child: const PropertyPanel(),
            )
          : null,
      body: Column(
        children: [
          const Toolbar(),
          Expanded(
            child: Row(
              children: [
                if (!isMobile)
                  const SizedBox(
                    width: sidePanelWidth,
                    child: ResourcePanel(),
                  ),
                Expanded(
                  child: CanvasArea(
                    onElementSelected: (id) {
                      ref.read(canvasProvider.notifier).selectElement(id);
                    },
                  ),
                ),
                if (!isMobile)
                  const SizedBox(
                    width: sidePanelWidth,
                    child: PropertyPanel(),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: isMobile
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'resource',
                  mini: true,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Icon(Icons.menu),
                  tooltip: '资源库',
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: 'property',
                  mini: true,
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: const Icon(Icons.tune),
                  tooltip: '属性栏',
                ),
              ],
            )
          : null,
    );
  }
} 