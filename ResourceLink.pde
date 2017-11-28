class ResourceLink{
  String url;
  String type;
  String filetype;
  ResourceLink(String url, String type, String ft){
    this.url = url;
    this.type = type;
    this.filetype = ft;

  }
  
  String getUrl(){
    return url;
  }
  
  String getType(){
    return type;
  }
  
  String getFileType(){
    return filetype;
  }
}