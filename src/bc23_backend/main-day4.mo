import List "mo:base/List";
import Book "./book";
import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Utils "./utils";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";

actor {
    public type List<T> = ?(T, List<T>);
    type Order = {#equal; #greater; #less};

    // Challenge 1: Write a function unique that takes a list l of type List and returns a new list with all duplicate elements removed.
    let unique = func<T>(l: List<T>, equal: (t1: T, t2: T) -> Order) : List<T> {
        let buffer = Buffer.fromArray<T>(List.toArray<T>(l));
        Buffer.removeDuplicates<T>(buffer, equal);

        return List.fromArray<T>(Buffer.toArray<T>(buffer));
    };

    // Enter in: 5,10,5,15,10
    // Gives: (opt record {5; opt record {10; opt record {15; null}}})
    public query func uniqueTextVals(l : List<Text>) : async List<Text> {
      return unique<Text>(l, Text.compare);
    };

    // Enter in: a,b,c,c,d,a
    // Gives: (opt record {"a"; opt record {"b"; opt record {"c"; opt record {"d"; null}}}})
    public query func uniqueIntVals(l : List<Int>) : async List<Int> {
      return unique<Int>(l, Int.compare);
    };

    // Challenge 2: Write a function reverse that takes l of type List and returns the reversed list.
    let reverse = func<T>(l : List<T>) : List<T> {
        return List.reverse(l);
    };

    // Enter in: first, second, third
    // Gives: (opt record {"third"; opt record {"second"; opt record {"first"; null}}})
    public query func reverseTextList(l: List<Text>) : async List<Text> {
        return reverse(l);
    };

    public shared query({caller}) func is_anonymous() : async Bool {
        return Principal.isAnonymous(caller);
    };

    // Challenge 4: Write a function find_in_buffer that takes two arguments, buf of type Buffer and val of type T, 
    // and returns the optional index of the first occurrence of "val" in "buf".
    let find_in_buffer = func<T>(buf: Buffer.Buffer<T>, val: T, equal: (T,T) -> Bool) : ?Nat {
        return Buffer.indexOf(val, buf, equal);
    };

    public query func find_in_buffer_text(l: List<Text>, val: Text) : async ?Nat {
        return find_in_buffer(Buffer.fromArray<Text>(List.toArray<Text>(l)), val, Text.equal);
    };


    let usernames = HashMap.HashMap<Principal, Text>(0, Principal.equal, Principal.hash);

    public shared ({ caller }) func add_username(name : Text) : async () {
      usernames.put(caller, name);
    };

    public query func get_usernames() : async [(Principal, Text)] {
      return Iter.toArray<(Principal, Text)>(usernames.entries());
    };
};
