class Filter {
  Filter({
   this.fromCity,
   this.toCity,
   this.fromDate,
   this.toDate,
  });

  int fromCity;
  int toCity;
  String fromDate;
  String toDate;

  @override
  String toString() => 'fromCity=$fromCity fromDate=$fromDate';

}
