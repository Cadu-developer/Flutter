
void main(List<String> arguments) {

for(int i = 1; i <= 50; i++){
  if(i % 3 == 0){
    print("Fizz");
  }

  else if(i % 5 == 0){
    print("Buzz");
  }

  else if(i % 3 == 0 && i % 5 == 0){
    print("FizzBuzz");
  }

  else{
    print("$i");
  }
}
}
