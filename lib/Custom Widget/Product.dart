class Product {
  var id;
  var image_url;
  var name;
  var description;
  var rating;
  var price;
  var quantity;
  Product(this.id,this.name,this.description,this.rating,this.price,this.image_url);
  Product.fromJson(json){
    id=json['id'];
    image_url=json['image_url'];
    name = json ['name'];
    description= json['description'];
    rating = json['rating'];
    price = json[ 'price'];
    quantity =0;
  }
}