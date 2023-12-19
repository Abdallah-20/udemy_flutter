import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/models/social_app/post_model.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';
import 'package:udemy_flutter/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      buildWhen: (previous, current) {return current is SocialGetPostsSuccessState;},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-vector/new-team-members-concept-illustration_114360-7381.jpg?w=996&t=st=1696771080~exp=1696771680~hmac=c025f23f7eb5d1b5757ab89bd2c99f316b405bc8d9c1106ff301233f737191c6'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate With Friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 7.0,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(
                                height: 1,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defultColor,
                              size: 18,
                            ),
                          ],
                        ),
                        Text(
                          '${model.datTime}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 5.0,
              //     bottom: 10.0,
              //   ),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 5.0),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .caption
              //                     ?.copyWith(color: defultColor),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 5.0),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Software_development',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .caption
              //                     ?.copyWith(color: defultColor),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(model.postImage != '')
                Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                              '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit.get(context).comments[index]} Comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Write a Comment ...',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Arrow___Up_Square,
                          color: Colors.green,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Share',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
