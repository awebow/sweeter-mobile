import 'package:flutter/material.dart';
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/sweet/sweet_list.dart';
import 'package:sweeter_mobile/user/user_bloc.dart';
import 'package:sweeter_mobile/user/user_list_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sweeter_mobile/api.dart' as api;

class UserPage extends StatefulWidget {

  final User user;

  UserPage(this.user);

  @override
  State<StatefulWidget> createState() {
    return UserPageState(user);
  }

}

class UserPageState extends State<UserPage> {

  final UserBloc bloc;
  final User user;

  UserPageState(this.user) : bloc=UserBloc(user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: RefreshIndicator(
        onRefresh: bloc.refreshSweets,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              actions: [
                StreamBuilder<String>(
                  initialData: "",
                  stream: bloc.relationStream,
                  builder: (context, snapshot) {
                    if(snapshot.data == "none" || snapshot.data == "followed")
                      return FlatButton(
                        child: Text("Follow", style: TextStyle(color: Colors.white)),
                        onPressed: () => bloc.follow(),
                      );
                    else if(snapshot.data == "following" || snapshot.data == "both")
                      return FlatButton(
                        child: Text("Unfollow", style: TextStyle(color: Colors.white)),
                        onPressed: () => bloc.unfollow(),
                      );
                    else
                      return Container();
                  },
                )
              ],
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  double ratio = (constraints.biggest.height - 72) / 152;
                  double interpolated = ratio - (1 - ratio) * 0.5;
                  if(interpolated < 0)
                    interpolated = 0;
                  return FlexibleSpaceBar(
                    background: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                      Container(
                        width: 80 * interpolated,
                        height: 80 * interpolated,
                        child: StreamBuilder<String>(
                          stream: bloc.pictureStream,
                          initialData: user.picture,
                          builder: (context, snapshot) {
                            return CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(snapshot.data == null
                                ? "https://i.stack.imgur.com/34AD2.jpg"
                                : api.serverUrl + "/statics/${snapshot.data}"),
                                child: InkWell(onTap: () => askChangePicture(context)),
                              );
                          }
                        )
                      ),
                      Container(height: 5 * interpolated),
                      Text(user.name, style: TextStyle(
                        color: Colors.white,
                        fontSize: 20 * interpolated
                      )),
                      Container(height: 10 * interpolated),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        StreamBuilder<List<User>>(
                          stream: bloc.followingsStream,
                          initialData: [],
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserListPage("Followings of ${user.name}", snapshot.data))),
                              child: Column(children: <Widget>[
                                Text("Following", style: TextStyle(
                                  fontSize: 16 * interpolated,
                                  color: Colors.white
                                )),
                                Text(snapshot.data.length.toString(), style: TextStyle(
                                  fontSize: 16 * interpolated,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ))
                              ]),
                            );
                          }
                        ),
                        Container(width: 32 * interpolated),
                        StreamBuilder<List<User>>(
                          stream: bloc.followersStream,
                          initialData: [],
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserListPage("Followers of ${user.name}", snapshot.data))),
                              child: Column(children: <Widget>[
                                Text("Followers", style: TextStyle(
                                  fontSize: 16 * interpolated,
                                  color: Colors.white
                                )),
                                Text(snapshot.data.length.toString(), style: TextStyle(
                                  fontSize: 16 * interpolated,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ))
                              ]),
                            );
                          }
                        )
                      ]),
                      Container(height: 15 + 85 * (1 - interpolated))
                    ])
                  );
                }
              )
            ),
            SliverList(delegate: SliverChildListDelegate([
              SweetList(bloc.sweetsStream, scrollable: false)
            ]))
          ],
        ),
      ),
    );
  }

  askChangePicture(BuildContext context) {
    if(bloc.relation == "self")
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Change picture?"),
          content: Text("Do you want to change your profile picture?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                ImagePicker.pickImage(source: ImageSource.gallery).then((file) => bloc.uploadProfile(file));
                Navigator.of(context).pop();
              },
            )
          ],
        )
      );
  }

}