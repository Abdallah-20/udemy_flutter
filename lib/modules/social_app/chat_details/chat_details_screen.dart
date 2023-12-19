import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/models/social_app/message_model.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';
import 'package:udemy_flutter/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;
  var messageController = TextEditingController();

  ChatDetailsScreen({this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context)
          .getMessages(receiverId: userModel!.uId.toString());

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${userModel?.image}'),
                ),
                SizedBox(width: 15),
                Text('${userModel?.name}'),
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).messages.length > 0,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var message = SocialCubit.get(context).messages[index];

                        if (SocialCubit.get(context).userModel?.uId ==
                            message.senderId) {
                          return buildMyMessage(message);
                        } else {
                          return buildMessage(message);
                        }
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: SocialCubit.get(context).messages.length,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here ...',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          color: defultColor,
                          child: MaterialButton(
                            onPressed: () {
                              SocialCubit.get(context).sendMessage(
                                dateTime: DateTime.now().toString(),
                                receiverId: '${userModel?.uId}',
                                text: messageController.text,
                              );
                            },
                            minWidth: 1,
                            child: Icon(
                              IconBroken.Send,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    });
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
            color: Colors.grey[300],
          ),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text('${model.text}'),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
            color: defultColor.withOpacity(0.2),
          ),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text('${model.text}'),

        ),
      );
}
