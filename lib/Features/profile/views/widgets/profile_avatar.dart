import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/Features/profile/views/widgets/custom_image_item.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/utils/app_size.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  final ValueNotifier<XFile?> _pickedImageNotifier = ValueNotifier(null);

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image != null) {
        _pickedImageNotifier.value = image;
        _saveImageLocally(image);
      }

      return image;
    } catch (e) {
      log('Image pick error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final main = context.watch<MainController>();

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              ValueListenableBuilder<XFile?>(
                valueListenable: _pickedImageNotifier,
                builder: (context, pickedImage, _) {
                  if (pickedImage != null) {
                    return CircleAvatar(
                      radius: AppSize.r(50),
                      backgroundImage: FileImage(File(pickedImage.path)),
                    );
                  } else if (main.userImagePath != null && main.userImagePath!.isNotEmpty) {
                    return CircleAvatar(
                      radius: AppSize.r(50),
                      backgroundImage: FileImage(File(main.userImagePath!)),
                    );
                  } else {
                    return CircleAvatar(
                      radius: AppSize.r(50),
                      backgroundImage: const AssetImage(
                        AssetsManager.imagesAhmed,
                      ),
                    );
                  }
                },
              ),

              /// Camera Button
              Positioned(
                bottom: -5,
                right: 0,
                child: InkWell(
                  onTap: () => _showPickImageSheet(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: AppSize.sp(26),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPickImageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: CustomImageItem(pickImage: pickImage),
        );
      },
    );
  }

  Future<void> _saveImageLocally(XFile file) async {
    try {
      final main = context.read<MainController>();

      final dir = await getApplicationDocumentsDirectory();

      final originalFile = File(file.path);

      final path = '${dir.path}/${file.name}';

      final copiedFile = await originalFile.copy(path);

      main.updateUserImage(copiedFile.path);

      log("Image saved: $path");
    } catch (e) {
      log('Error saving image locally: $e');
    }
  }
}
