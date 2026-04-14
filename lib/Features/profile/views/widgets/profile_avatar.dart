import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/Features/profile/views/widgets/custom_image_item.dart';
import 'package:todo_app/Features/profile/views/widgets/user_profile_info.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/utils/app_size.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  final ValueNotifier<XFile?> _pickedImgeNotifier = ValueNotifier(null);
  final ValueNotifier<String> imageNotifier = ValueNotifier('');

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image != null) {
        _pickedImgeNotifier.value = image;
        _saveImageLocally();
      }

      return image;
    } catch (e) {
      log('Image pick error: $e');
      return null;
    }
  }

  void _fetchUserImage() {
    imageNotifier.value = PreferenceManager.getData<String>('image') ?? "";
  }

  @override
  void initState() {
    super.initState();
    _fetchUserImage();
  }

  @override
  Widget build(BuildContext context) {
    log('Build');
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30),

          /// Avatar
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              ValueListenableBuilder<XFile?>(
                valueListenable: _pickedImgeNotifier,
                builder: (context, pickedImage, _) {
                  if (pickedImage != null) {
                    return CircleAvatar(
                      radius: AppSize.r(50),
                      backgroundImage: FileImage(File(pickedImage.path)),
                    );
                  } else if (imageNotifier.value.isNotEmpty) {
                    return CircleAvatar(
                      radius: AppSize.r(50),
                      backgroundImage: FileImage(File(imageNotifier.value)),
                    );
                  } else {
                    return CircleAvatar(
                      radius: AppSize.r(50),
                      backgroundImage: AssetImage(AssetsManager.imagesAhmed),
                    );
                  }
                },
              ),

              /// Camera Button
              Positioned(
                bottom: -5, // Adjusted for better positioning
                right: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    _showPickImageSheet(context);
                  },
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

          const SizedBox(height: 8),

          /// User Info
          const UserProfileInfo(),
        ],
      ),
    );
  }

  /// Bottom Sheet
  void _showPickImageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: CustomImageItem(pickImage: pickImage),
        );
      },
    );
  }

  void _saveImageLocally() async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final File originalFile = File(_pickedImgeNotifier.value!.path);
      final String destinationPath =
          '${appDir.path}/${_pickedImgeNotifier.value!.name}';
      final File copiedFile = await originalFile.copy(destinationPath);
      await PreferenceManager.setData<String>('image', copiedFile.path);
      log("copiedFile saved on: $copiedFile");
    } catch (e) {
      log('Error saving image locally: $e');
    }
  }
}
