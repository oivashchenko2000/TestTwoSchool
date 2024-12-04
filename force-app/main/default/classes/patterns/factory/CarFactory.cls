public with sharing class CarFactory {

    public static Car createCar(String carName) {
        switch on carName {
            when 'Audi' {
                return new Audi();
            }
            when 'Skoda' {
                return new Skoda();
            }
            when else {
                return new Audi();
            }
        }
    }
}