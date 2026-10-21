# Static and Dynamic Binding in C#

## Objective

Demonstrate dynamic binding and static binding in C#, and show how the `virtual`, `override` and `new` keywords control which version of a method runs.

## Code design

| Class | Relationship | Methods |
|---|---|---|
| `Animal` | base class | `Speak()` (virtual), `Sleep()` (not virtual) |
| `Dog` | inherits from `Animal` | `Speak()` (override), `Sleep()` (new) |

```csharp
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
```

`Main` creates three variables:

| Variable | Declared type | Actual object |
|---|---|---|
| `animal` | `Animal` | `Animal` |
| `myDog` | `Animal` | `Dog` |
| `realDog` | `Dog` | `Dog` |

The interesting variable is `myDog`: its declared type and its actual object are different.

## Keywords

**`virtual`** marks a base class method that derived classes are allowed to replace.

**`override`** replaces a virtual method in a derived class. The method that runs is chosen at **runtime** from the actual object's type. This is **dynamic binding**.

**`new`** hides a base class method with a new one of the same name. The method that runs is chosen at **compile time** from the variable's declared type. This is **static binding**.

A normal method without `virtual` is also statically bound.

## How to run

Paste the code into an online C# compiler such as OnlineGDB, or run it locally.

## Output

```
--- override (dynamic binding) ---
Animal makes a sound
Dog barks
Dog barks

--- new (static binding) ---
Animal sleeps
Dog sleeps
```

## Explanation of the results

| Call | Declared type | Actual object | Output | Why |
|---|---|---|---|---|
| `animal.Speak()` | Animal | Animal | Animal makes a sound | Ordinary call on a base object |
| `myDog.Speak()` | Animal | Dog | Dog barks | `Speak` is virtual and overridden, so the actual object (`Dog`) decides at runtime |
| `realDog.Speak()` | Dog | Dog | Dog barks | Same override |
| `myDog.Sleep()` | Animal | Dog | Animal sleeps | `Sleep` is hidden with `new`, so the declared type (`Animal`) decides at compile time |
| `realDog.Sleep()` | Dog | Dog | Dog sleeps | The declared type is `Dog`, so `Dog`'s version is used |

The key comparison is `myDog.Speak()` against `myDog.Sleep()`. The variable and the object are the same, but the results differ. `Speak` is overridden, so the object's real type decides. `Sleep` is hidden with `new`, so the variable's type decides.


Java has no equivalent of `virtual` or `new` for instance methods. All instance methods are virtual by default, so hiding by method name is not possible there.
