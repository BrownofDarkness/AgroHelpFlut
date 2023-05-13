
String clipper(length, text, maxlength){
  String half;
  if(text.length > maxlength){
    half = "${text.substring(0, length)}...";
  }else{
  half = text;
  }

  return half;
}