import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const AvatarWidget({
    super.key,
    this.imageUrl,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.white,
      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
          ? NetworkImage(imageUrl!)
          : const AssetImage('assets/images/default_avatar.png')
              as ImageProvider,
    );
  }
}