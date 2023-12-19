import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxpgNqUW1ruYOHOg6gtNwlAB-R0Fw85iINklvYgJE_6zEmxpvf'),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            'Chats',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 22,
                  ))),
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 24,
                  ))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Search',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildStoryItem(),
                    separatorBuilder: (context, index) => const SizedBox(width: 5.0),
                    itemCount: 10),
              ),
              SizedBox(
                height: 8,
              ),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 5.0,
                      ),
                  itemCount: 10)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatItem() => Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxpgNqUW1ruYOHOg6gtNwlAB-R0Fw85iINklvYgJE_6zEmxpvf'),
              ),
              // CircleAvatar(
              //   radius: 9.5,
              //   backgroundColor: CupertinoColors.white.withOpacity(0.4),
              //
              // ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 2,
                  end: 1,
                ),
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: CupertinoColors.systemGreen,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abdallah Adel Mohammed',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Hello World; My Name Is Abdallah and this is my first app',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text(
                      '02:00 PM',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildStoryItem() => Container(
        width: 60,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxpgNqUW1ruYOHOg6gtNwlAB-R0Fw85iINklvYgJE_6zEmxpvf'),
                ),
                // CircleAvatar(
                //   radius: 9.5,
                //   backgroundColor: CupertinoColors.white.withOpacity(0.4),
                //
                // ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 2,
                    end: 1,
                  ),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: CupertinoColors.systemGreen,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Abdallah Adel Mohammed',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}
