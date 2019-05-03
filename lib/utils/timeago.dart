String timeago(DateTime time, DateTime current) {
  var duration = current.difference(time);
  var minDiff = DateTime.utc(current.year, current.month, current.day, current.hour, current.minute)
    .difference(DateTime(time.year, time.month, time.day, time.hour, time.minute));
  if(duration.inSeconds < 60)
    return "Just now";
  else if(minDiff.inMinutes == 1)
    return "A minute ago";
  else if(minDiff.inMinutes < 60)
    return "${duration.inMinutes} minutes ago";
  else if(minDiff.inHours == 1)
    return "An hour ago";
  
  var dateDiff = DateTime.utc(current.year, current.month, current.day)
    .difference(DateTime(time.year, time.month, time.day));
  
  if(dateDiff.inDays == 1)
    return "Yesterday";
  
  String month = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"][current.month - 1];

  time = time.toLocal();
  
  var hour12 = (time.hour > 12 ? time.hour - 12 : time.hour).toString().padLeft(2, "0");
  var minuteZero = time.minute.toString().padLeft(2, "0");
  String ampm = time.hour < 12 ? "AM" : "PM";
  if(time.year == current.year)
    return "$month ${time.day}, $hour12:$minuteZero $ampm";
  else
    return "$month ${time.day}. ${time.year}, $hour12:$minuteZero $ampm";
}
