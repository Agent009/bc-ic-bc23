import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Float "mo:base/Float";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import { equal } "mo:base/Nat";
import Blob "mo:base/Blob";
import Debug "mo:base/Debug";

actor {

    let is_array_size_even = func <T>(array : [T]) : Bool {
        let size = array.size();
        if (size % 2 == 0) {
            return true;
        } else {
            return false;
        };
    };

    public query func nat_arr_size_even(array : [Nat]) : async Bool {
        return is_array_size_even<Nat>(array);
    };

};
