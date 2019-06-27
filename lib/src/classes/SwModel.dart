abstract class SwModel{
  static parseDate(String date){
    return date != null ? DateTime.parse(date) : null;
  }
}