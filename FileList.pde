class FileList{
  String fileLocation[] = {};
  FileList(){
  }
  
  void add(String url){
    if(url.length() > 0){
      fileLocation = append(fileLocation, url);
    }
  }
  
  String[] getList(){
    return fileLocation;
  }
  
  void showList(){
    for(int i=0; i<fileLocation.length; i++){
      println(fileLocation[i]);
    }
  }
}