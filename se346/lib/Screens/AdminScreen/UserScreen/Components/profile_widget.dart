import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser!.reload();
    final color = Theme.of(context).colorScheme.primary;
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        return Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(color),
              ),
            ],
          ),
        );
      }
    );
  }
  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        isEdit ? Icons.add_a_photo : Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

Widget buildName() => Column(
  children: [
    Text(
      FirebaseAuth.instance.currentUser!.displayName!,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ),
    const SizedBox(height: 4),
    Text(
      FirebaseAuth.instance.currentUser!.email!,
      style: TextStyle(color: Colors.grey),
    )
  ],
);
