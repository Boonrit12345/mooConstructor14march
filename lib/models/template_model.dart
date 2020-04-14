class TemplateModel {

  // Field
  String nameCar, colorCar;



  // Method
  TemplateModel(this.nameCar, this.colorCar);
  

  Map<String, dynamic> toMap(){
    
      Map<String, dynamic> map = Map();
      map['CarName'] = nameCar;
      map['CarColor'] = colorCar;

      return map;


  }

}