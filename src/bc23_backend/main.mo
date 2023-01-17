import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
actor {
    var languages : [Text] = ["English", "German", "Chinese", "Japanese", "French"];

    // dfx canister call bc23_backend add_language '("Urdu")'
    // Should give: (vec { "English"; "German"; "Chinese"; "Japanese"; "French"; "Urdu" })
    public func add_language(new_language : Text) : async [Text] {
        let buffer = Buffer.fromArray<Text>(languages);
        buffer.add(new_language);
        return Buffer.toArray(buffer);
    };

};
