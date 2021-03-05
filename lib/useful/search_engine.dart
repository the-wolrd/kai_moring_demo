class SearchEngine{
  static isContainSuchContent({String base, String key}){
    if(base == null || key == null){
      return false;
    }
    else{
      if (base.contains(key))
        return true;
      else return false;
    }

  }

}