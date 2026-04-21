import 'dart:io';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/media_picker_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:filbet/generated/assets.dart';

typedef ImageItemBuilder = Widget Function(
  BuildContext context,
  File file,
  Function(File file) onRemove,
);

typedef PlaceholderBuilder = Widget Function();
typedef MenusBuilder = Widget Function(
  Function pickGallery,
  Function pickCamera,
);

class PictureSelector extends StatefulWidget {
  final int maxCount;
  final int columnCount;
  final bool uiStyle;
  final bool multiple;
  final ImageItemBuilder? itemBuilder;
  final PlaceholderBuilder? placeholderBuilder;
  final MenusBuilder? menusBuilder;
  final PictureSelectorController? controller;
  final VoidCallback? onChanged;

  const PictureSelector({
    super.key,
    this.maxCount = 9,
    this.columnCount = 3,
    this.uiStyle = false,
    this.multiple = false,
    this.itemBuilder,
    this.placeholderBuilder,
    this.menusBuilder,
    this.controller,
    this.onChanged,
  });

  @override
  State<PictureSelector> createState() => _PictureSelectorState();
}

class _PictureSelectorState extends State<PictureSelector> {
  final List<File> _images = [];

  @override
  void initState() {
    super.initState();
    widget.controller?._bind(this);
  }

  @override
  Widget build(BuildContext context) {
    final showAdd = _images.length < widget.maxCount;

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: widget.uiStyle
          ? Column(
              children: [
                SizedBox(
                  height: 86.h,
                  width: 86.w,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.columnCount,
                      crossAxisSpacing: 10.r,
                      mainAxisSpacing: 10.r,
                    ),
                    itemCount: _images.length + (showAdd ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < _images.length) {
                        final file = _images[index];
                        return _buildImageItem(file);
                      }
                      return _buildAddButton();
                    },
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: _showMenu,
                    child: Container(
                      height: 37.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: appnewColors.bgBlue,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      margin: EdgeInsets.only(top: 10.r),
                      child: Text(
                        "上传二维码",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.columnCount,
                crossAxisSpacing: 10.r,
                mainAxisSpacing: 10.r,
              ),
              itemCount: _images.length + (showAdd ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _images.length) {
                  final file = _images[index];
                  return _buildImageItem(file);
                }
                return _buildAddButton();
              },
            ),
    );
  }

  /// --- UI 部分 ---
  Widget _buildImageItem(File file) {
    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(context, file, _removeFile);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.file(file, fit: BoxFit.cover),
        ),
        Positioned(
          right: 1,
          top: 1,
          child: InkWell(
            onTap: () => _removeFile(file),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAddButton() {
    if (widget.placeholderBuilder != null) {
      return GestureDetector(
        onTap: _showMenu,
        child: widget.placeholderBuilder!(),
      );
    }

    return GestureDetector(
      onTap: _showMenu,
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(
          Assets.mineIconUpload,
          width: 48.r,
          height: 48.r,
        ),
      ),
    );
  }

  /// --- 功能部分 ---
  void _removeFile(File file) {
    _images.remove(file);
    setState(() {});
    widget.onChanged?.call();
  }

  Future _pickGallery() async {
    try {
      // 关闭底部弹窗
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      // 等待一小段时间，确保底部弹窗完全关闭
      await Future.delayed(const Duration(milliseconds: 100));
      if (widget.multiple) {
        final list = await ImagePicker().pickMultiImage();
        if (list != null) {
          final left = widget.maxCount - _images.length;
          _images.addAll(list.take(left).map((e) => File(e.path)));
        }
      } else {
        print("object123456");
        final file = await MediaPickerUtil.pickImage();
        if (file != null) _images.add(File(file.path));
      }
      setState(() {});
      widget.onChanged?.call();
    } catch (e) {
      // 如果平台通道连接失败，可以在这里显示错误提示
      debugPrint('Image picker error: $e');
    }
  }

  Future _pickCamera() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.camera);
      if (file != null) _images.add(File(file.path));
      Navigator.pop(context);
      setState(() {});
      widget.onChanged?.call();
    } catch (e) {
      Navigator.pop(context);
      // 如果平台通道连接失败，可以在这里显示错误提示
      debugPrint('Image picker error: $e');
    }
  }

  void _showMenu() {
    showModalBottomSheet(
        context: context,
        elevation: 3,
        barrierColor: Color(0xA6000000),
        isDismissible: true,
        useSafeArea: true,
        builder: (c) {
          if (widget.menusBuilder != null) {
            return widget.menusBuilder!.call(_pickGallery, _pickCamera);
          }
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 185.h,
              minHeight: 185.h,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.h),
                topRight: Radius.circular(8.h),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _pickCamera,
                    child: Container(
                      height: 65.h,
                      color: Color(0xffFFFFFF),
                      alignment: Alignment.center,
                      child: Text(
                        '拍照',
                        style: TextStyle(
                            color: Color(0xff494747), fontSize: 14.sp),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xffE8E8E8),
                    height: 1.h,
                  ),
                  GestureDetector(
                    onTap: _pickGallery,
                    child: Container(
                      height: 65.h,
                      color: Color(0xffFFFFFF),
                      alignment: Alignment.center,
                      child: Text(
                        '从手机相册选择',
                        style: TextStyle(
                            color: Color(0xff494747), fontSize: 14.sp),
                      ),
                    ),
                  ),
                  Container(
                    height: 10.h,
                    color: Color(0xffF7F7F7),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 44.h,
                      color: Color(0xffFFFFFF),
                      alignment: Alignment.center,
                      child: Text(
                        '取消',
                        style: TextStyle(
                            color: Color(0xff494747), fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// 给 controller 用
  void _clear() {
    _images.clear();
    setState(() {});
    widget.onChanged?.call();
  }

  List<File> _getFiles() => List.unmodifiable(_images);
}

class PictureSelectorController {
  _PictureSelectorState? _state;

  void _bind(_PictureSelectorState state) {
    _state = state;
  }

  void clear() => _state?._clear();

  List<File> get files => _state?._getFiles() ?? [];
}
