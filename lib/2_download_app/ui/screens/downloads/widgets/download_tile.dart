import 'package:flutter/material.dart';
 
import '../../../theme/theme.dart';
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;
 
 // TODO
  // IconData get icon => controller.status == DownloadStatus.notDownloaded ? Icons.download : controller.status == DownloadStatus.downloading ? Icons.downloading : Icons.folder;
  IconData get icon {
    switch (controller.status) {
      case DownloadStatus.notDownloaded:
        return Icons.download;
      case DownloadStatus.downloading:
        return Icons.downloading;
      case DownloadStatus.downloaded:
        return Icons.folder;
    }
  }
  String get percentage => (controller.progress * 100).toStringAsFixed(1);
  double get progress => controller.ressource.size * controller.progress;
  int get size => controller.ressource.size;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder:(context, child) => Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.ressource.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 5),
                Text(
                  "$percentage % completed - $progress of $size MB",
                  style: TextStyle(fontSize: 16, color: AppColors.neutralDark),
                ),
              ],
            ),
            IconButton(
              onPressed: controller.startDownload, 
              icon: Icon(icon)
            )
          ],
        ),
      ),
    );
  }
}
