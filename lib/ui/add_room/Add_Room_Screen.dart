import 'package:chatnow/component/Custom_Text_Form_Field.dart';
import 'package:chatnow/model/Room_Category.dart';
import 'package:chatnow/ui/add_room/Add_Room_View_Model.dart';
import 'package:chatnow/ui/base/Base.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'addRoomScreen';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomDescriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<RoomCategory> allCats = RoomCategory.getRoomCategories();
  RoomCategory? selectedRoomCategories;

  @override
  void initState() {
    super.initState();
    selectedRoomCategories = allCats[0];
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/images/login_pattern.png'),
              fit: BoxFit.fill),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Chat Now'),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: 334,
              height: 600,
              padding: EdgeInsets.only(left: 25, right: 25, top: 24),
              margin: EdgeInsets.only(left: 40, right: 40, top: 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff3030301A),
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: Offset(0, 5))
                  ]),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Create New Room',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      Image.asset('assets/images/creat_room_image.png'),
                      CustomTextFormField(
                        labelText: "Enter Room Name",
                        controller: roomNameController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please Enter Room Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButton<RoomCategory>(
                          isExpanded: true,
                          value: selectedRoomCategories,
                          items: allCats.map((cat) {
                            return DropdownMenuItem<RoomCategory>(
                                value: cat,
                                child: Row(
                                  spacing: 5,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/${cat.imageName}',
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                    Text(cat.name),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (item) {
                            selectedRoomCategories = item;
                            setState(() {});
                          }),
                      CustomTextFormField(
                        labelText: "Enter Room Description",
                        controller: roomDescriptionController,
                        lines: 2,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please Enter Room Description";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 40, top: 80),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff3598DB),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            onPressed: () {
                              creatRoom(context);
                            },
                            child: Text(
                              'Create',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            )),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void creatRoom(context) async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.addRoom(roomNameController.text, roomDescriptionController.text,
        selectedRoomCategories!.id, context);
  }
}
