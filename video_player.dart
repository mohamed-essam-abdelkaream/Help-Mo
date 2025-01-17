import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:shimmer/shimmer.dart';

class VideoDemo extends StatefulWidget {
  final String videoUrl;

  VideoDemo({required this.videoUrl});

  @override
  _VideoDemoState createState() => _VideoDemoState();
}

class _VideoDemoState extends State<VideoDemo> {
  late BetterPlayerController _controller;
  bool _isLoading = true; // حالة التحميل

  @override
  void initState() {
    super.initState();
    _controller = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true, // التشغيل التلقائي
        looping: true, // التكرار التلقائي
        aspectRatio: 16 / 9, // نسبة العرض إلى الارتفاع
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false, // إخفاء عناصر التحكم
          enableProgressBar: false, // إخفاء شريط التقدم
          enablePlaybackSpeed: false, // إخفاء خيار سرعة التشغيل
          enableSkips: false, // إخفاء أزرار التخطي
          enableFullscreen: false, // إخفاء زر التكبير
          enableMute: false, // إخفاء زر كتم الصوت
          enableRetry: false, // إخفاء زر إعادة المحاولة
          enableOverflowMenu: false, // إخفاء القائمة الإضافية
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(widget.videoUrl),
    );

    // الاستماع إلى أحداث التحميل
    _controller.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        setState(() {
          _isLoading = false; // تم تحميل الفيديو
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // عرض الفيديو
        BetterPlayer(controller: _controller),

        // عرض تأثير Shimmer أثناء التحميل
        if (_isLoading)
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!, // اللون الأساسي للتوهج
            highlightColor: Colors.grey[100]!, // اللون المضيء للتوهج
            child: Container(
              color: Colors.white, // لون الخلفية
              width: double.infinity,
              height: MediaQuery.of(context).size.width * (9 / 16), // نسبة العرض إلى الارتفاع 16:9
            ),
          ),
      ],
    );
  }
}