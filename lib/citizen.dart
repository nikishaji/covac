class Citizen{
    String name,streetname,location,state,occupation,placebooked;
    DateTime date;
    bool isbooked,isvaccinated,isrequestbooking,isbadge1,isbadge2,isbadge3,isbadge4,isbadge5;
    int age,pincode,aaharcardno,houseno,mobileno,badgeno  ;

    Citizen({
    this.name,
    this.streetname,
    this.location,
    this.state,
    this.age,
    this.pincode,
    this.aaharcardno,
    this.houseno,
    this.mobileno,
    this.occupation,
    this.date,
    this.isbooked=false,
    this.isvaccinated=false,
    this.isrequestbooking=false,
    this.placebooked,
    this.isbadge1=true,
    this.isbadge2=false,
    this.isbadge3=false,
    this.isbadge4=false,
    this.isbadge5=false,
    this.badgeno=1,
    });
}