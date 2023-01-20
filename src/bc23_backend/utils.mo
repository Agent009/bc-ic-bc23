import Array "mo:base/Array";
import Bool "mo:base/Bool";
import Buffer "mo:base/Buffer";
import Int "mo:base/Int";
import Hash "mo:base/Hash";
import List "mo:base/List";
import Option "mo:base/Option";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Order "mo:base/Order";
import Text "mo:base/Text";

module Utils {

    // Takes an array [Int] of integers and returns the second largest number in the array.
    public func second_maximum(array : [Int]) : Int {
        if (array.size() < 1) {
            return 0;
        } else {
            if (array.size() == 1) {
                return array[0];
            } else {
                Array.sort<Int>(array, Int.compare)[array.size() - 2];
            };
        };
    };

    // Takes an array [Nat] and returns a new array with only the odd numbers from the original array.
    public func remove_even(array : [Nat]) : [Nat] {
        let buffer = Buffer.Buffer<Nat>(3);

        for (num in array.vals()) {
            // We like the odd ones...
            if (num % 2 > 0) {
                buffer.add(num);
            };
        };

        return Buffer.toArray<Nat>(buffer);
    };

    // Takes 2 parameters: an array [T] and a Nat n. This function will drop the n first elements of the array and returns the remainder.
    // Do not use a loop.
    public func drop<T>(xs : [T], n : Nat) : [T] {
        // So, we want to drop more elements than there are present... rightio! 
        if (n >= xs.size()) {
            return [];
        };
    
        // If we don't want to drop anything, then why did we even come here for?!
        if (n <= 0) {
            return xs;
        };

        let buffer = Buffer.fromArray<T>(xs);
        // n will always be more than 0 at this point, so will not trap despite the syntax warning below.
        buffer.filterEntries(func(i, x) = i > (n - 1));

        return Buffer.toArray<T>(buffer);
    };

    public func dropFromText(xs : [Text], n : Nat) : [Text] {
      return drop<Text>(xs, n);
    };

    public func dropFromInt(xs : [Int], n : Nat) : [Int] {
      return drop<Int>(xs, n);
    };

    // Add the new item to the beginning of the list.
    public func prependToList<T>(list : List.List<T>, newItem : T) : List.List<T> {
        List.push<T>(newItem, list);
    };

    let array_even = func<T>(array : [T]) : Bool {
        let size = array.size();
        if (size % 2 == 0) {
            return true;
        } else {
            return false;
        };
    };

    public func text_array_even(array : [Text]) : Bool {
        return array_even<Text>(array);
    };

    public func nat_array_even(array : [Nat]) : Bool {
        return array_even<Nat>(array);
    };

    public type List<T> = ?(T, List<T>);
    type Order = {#equal; #greater; #less};

    // Challenge 1: Write a function unique that takes a list l of type List and returns a new list with all duplicate elements removed.
    public func unique<T>(l: List<T>, equal: (t1: T, t2: T) -> Order) : List<T> {
        let buffer = Buffer.fromArray<T>(List.toArray<T>(l));
        Buffer.removeDuplicates<T>(buffer, equal);

        return List.fromArray<T>(Buffer.toArray<T>(buffer));
    };

    
};
