import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import '../../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel!.data;
        nameController.text = model!.name!;
        emailController.text = model.email!;
        phoneController.text = model.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Name Mustn\'t be empty';
                        }
                        return null;
                      },
                      label: 'User Name',
                      prefix: CupertinoIcons.profile_circled,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Email Mustn\'t be empty';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number Mustn\'t be empty';
                        }
                        return null;
                      },
                      label: 'Phone Number',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'Update ',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      function: () {
                        singOut(context);
                      },
                      text: 'Logout',
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
