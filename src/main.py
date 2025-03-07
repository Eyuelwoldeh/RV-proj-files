import os
import math

class Car():
    def __init__(self):
        self.name = "Deathstar"
        self.speed = 5000
    
    def accelerate(self, hm):
        self.speed += hm

    
def main():
    car = Car()

    print(car.name)
    car.accelerate(500)
    print(car.speed)

if __name__ == "__main__":
    main()