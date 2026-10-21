using System;

class Animal
{
    public virtual void Speak() { Console.WriteLine("Animal makes a sound"); }

    public void Sleep() { Console.WriteLine("Animal sleeps"); }
}

class Dog : Animal
{
    public override void Speak() { Console.WriteLine("Dog barks"); }

    public new void Sleep() { Console.WriteLine("Dog sleeps"); }
}

class Program
{
    static void Main()
    {
        Animal animal = new Animal();
        Animal myDog = new Dog();
        Dog realDog = new Dog();

        Console.WriteLine("--- override (dynamic binding) ---");
        animal.Speak();
        myDog.Speak();
        realDog.Speak();

        Console.WriteLine("\n--- new (static binding) ---");
        myDog.Sleep();
        realDog.Sleep();
    }
}