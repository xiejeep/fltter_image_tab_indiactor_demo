import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'xx_image_indicator.dart';


///自定义的tabbar
class XXTabbar extends StatefulWidget {
  final List<String> tabs;
  final TabController tabController;
  final bool isScrollable;
  final Color labelColor;
  final Color unselectedLabelColor;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final Function(int) onTap;
  final double height;
  final String indiactorIcon;
  final double distanceFromCenter;
  final Size indiactorSize;

///tabs 标题
///tabController 控制器
///isScrollable 是否允许滚动
///labelColor 选中文字颜色
///unselectedLabelColor 未选中文字颜色
///labelStyle 选中文字
///unselectedLabelStyle 未选中文字
///onTap 点击tab
///height 高度
///indiactorIcon 指示器图片
///distanceFromCenter 指示器上边距离
///indiactorSize 指示器大小
  XXTabbar({
   @required this.tabs,
    this.tabController,
    this.isScrollable = false,
    this.labelColor = const Color.fromRGBO(255, 255, 255, 1),
    this.unselectedLabelColor = const Color.fromRGBO(255, 255, 255, 1),
    this.labelStyle,
    this.unselectedLabelStyle,
    this.onTap,
    this.height = kToolbarHeight,
    this.indiactorIcon = 'assets/indiactor.jpg',
    this.distanceFromCenter = 10,
    this.indiactorSize = const Size(15, 8),
  });

  @override
  _XXTabbarState createState() => _XXTabbarState();
}

class _XXTabbarState extends State<XXTabbar> {
  //指示器图片future
  Future<ui.Image> imageFuture;
  @override
  void initState() {
    super.initState();
    ///先加载指示器图片,完成后通过FutureBuilder刷新tabbar
    imageFuture = XXImageIndicator.loadImage(widget.indiactorIcon);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //指示器图片加载未完成时,显示空指示器
    return Container(
        height: widget.height,
        child: FutureBuilder<ui.Image>(
          future: imageFuture,
          builder: (context, AsyncSnapshot snapshot) => TabBar(
            tabs: widget.tabs.map((title) => new Text(title)).toList(),
            controller: widget.tabController,
            indicator: snapshot.hasData
                ? XXImageIndicator(
                    image: snapshot.data,
                    distanceFromCenter: widget.distanceFromCenter,
                    imageSize: widget.indiactorSize)
                : new ShapeDecoration(shape: Border()),
            isScrollable: widget.isScrollable,
            labelColor: widget.labelColor,
            unselectedLabelColor: widget.unselectedLabelColor,
            labelStyle: widget.labelStyle,
            unselectedLabelStyle: widget.unselectedLabelStyle,
            // onTap: widget.onTap,
          ),
        )
        );
  }
}
