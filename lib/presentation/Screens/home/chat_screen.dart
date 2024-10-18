import 'dart:developer';
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/home/chat/chat_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/imagePicker/image_picker_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;
  late TextEditingController messageController;
  late ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();
    chatBloc = ChatBloc();
    scrollController = ScrollController();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    chatBloc.close();
    scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => chatBloc..add(const GetRoomMessages()),
        ),
        BlocProvider(
          create: (context) => ImagePickerBloc(chatBloc),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: CustomAppBar.leadingTitle(
              centerTitle: false,
              leadingWidth: 40,
              title: 'Halk Market',
              withSubtitle: AppLocalization.of(context)
                      .getTransatedValues('willResponse') ??
                  '',
              needBoxshadow: true,
            ),
            body: Column(
              children: [
                // Chat messages
                Expanded(
                  child: BlocBuilder<ChatBloc, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ChatLoaded) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollToBottom();
                        });
                        log('Displaying messages: //${state.messages}');

                        return ListView.builder(
                          controller: scrollController,
                          reverse: true,
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            final message = state.messages[index];
                            final isClient = message['author'] == 'client';

                            // Ensure consistent alignment based on sender
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 10,
                              ), // Uniform padding
                              alignment: isClient
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: isClient
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  // Image message
                                  if (message['attachment'] != null &&
                                      message['attachment'].isNotEmpty)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.grey2Color,
                                        borderRadius: AppBorders.borderRadius12,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: AppBorders.borderRadius12,
                                        child: ExtendedImage.file(
                                          File(message['attachment']),
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  if (message['text'].isNotEmpty)
                                    const SizedBox(
                                      height: 10,
                                    ),

                                  // Text message
                                  if (message['text'].isNotEmpty)
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: isClient
                                            ? AppColors.lightBlueColor
                                            : AppColors.lightPurpleColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ).copyWith(
                                          bottomRight: Radius.circular(
                                            isClient == true ? 0 : 20,
                                          ),
                                          bottomLeft: Radius.circular(
                                            isClient == false ? 0 : 20,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        message['text'],
                                        style: TextStyle(
                                          fontSize: AppFonts.fontSize16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.darkPurpleColor,
                                        ),
                                      ),
                                    ),
                                  Text(
                                    formatDate(message['createdAt']),
                                    style: TextStyle(
                                      fontSize: AppFonts.fontSize12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey5Color,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (state is ChatError) {
                        return Center(child: Text(state.message));
                      } else {
                        return const Center(
                          child: Text('Start a conversation!'),
                        );
                      }
                    },
                  ),
                ),

                // Textfield for sending messages
                BlocBuilder<ImagePickerBloc, ImagePickerState>(
                  builder: (context, imageState) {
                    return CustomTextField.normal(
                      backColor: AppColors.whiteColor,
                      nonActiveBorderColor: AppColors.grey2Color,
                      textEditingController: messageController,
                      hintText: AppLocalization.of(context)
                              .getTransatedValues('writeMessage') ??
                          '',
                      needPrefix: IconButton(
                        onPressed: () {
                          context
                              .read<ImagePickerBloc>()
                              .add(GallaryImagePicker());
                        },
                        icon: SvgPicture.asset(attachIcon),
                      ),
                      suffixWidget: IconButton(
                        onPressed: () {
                          log('image ${imageState.file?.path}');
                          final messageText = messageController.text;
                          if (messageText.isNotEmpty) {
                            context.read<ChatBloc>().add(
                                  SendMessage(
                                    text: messageText,
                                    attachment: '',
                                    author: 'client',
                                  ),
                                );
                            messageController.clear();
                          }
                        },
                        icon: SvgPicture.asset(sendIcon),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

String formatDate(String dateString) {
  final DateTime parsedDate = DateTime.parse(dateString);
  final DateFormat formatter = DateFormat('dd.MM.yyyy, HH:mm');
  return formatter.format(parsedDate);
}
