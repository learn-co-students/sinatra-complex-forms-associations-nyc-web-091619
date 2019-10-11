Don't understand how 

Creating New Owners with Associated Pets in the Controller
We are familiar with using mass assignment to create new instances of a class with Active Record. For example, if we had a hash, owner_info, that looked like this...

owner_info = {name: "Adele"}
...we could easily create a new owner like this:

Owner.create(owner_info)
But our params hash contains this additional key of "pet_ids" pointing to an array of pet ID numbers. You may be wondering if we can still use mass assignment here. Well, the answer is yes. Active Record is smart enough to take that key of pet_ids, pointing to an array of numbers, find the pets that have those IDs, and associate them to the given owner, all because we set up our associations such that an owner has many pets. Wow! Let's give it a shot. Still in your Pry console that you entered via the binding.pry in the post '/owners' action of the OwnersController, type:

@owner = Owner.create(params["owner"])
# => #<Owner:0x007fdfcc96e430 id: 2, name: "Adele">
It worked! Now, type:

@owner.pets
#=> [#<Pet:0x007fb371bc22b8 id: 1, name: "Maddy", owner_id: 2>, #<Pet:0x007fb371bc1f98 id: 2, name: "Nona", owner_id: 2>]
And our usage of mass assignment successfully associated the new owner with the pets whose ID numbers were in the params hash!

Now that we have this working code, let's go ahead and place it in our post '/owners' action:


-------
result of my pry incremented the id of owners and assigned me twice into the database

[1] pry(#<OwnersController>)> params
=> {"owner"=>{"name"=>"Altaf", "pet_ids"=>["1", "2"]}}
[2] pry(#<OwnersController>)> owner[pet_ids]
NameError: undefined local variable or method `owner' for #<OwnersController:0x00007f91b9c01b90>
from (pry):2:in `block in <class:OwnersController>'
[3] pry(#<OwnersController>)> owner_info = {name: "Altaf"}
=> {:name=>"Altaf"}
[4] pry(#<OwnersController>)> Owner.create(owner_info)
=> #<Owner:0x00007f91b83f4020 id: 2, name: "Altaf">
[5] pry(#<OwnersController>)> @owner = Owner.create(params["owner"])
/Users/altafquadri/.rvm/gems/ruby-2.6.1/gems/activerecord-4.2.5/lib/active_record/associations/collection_association.rb:267: warning: constant ::Fixnum is deprecated
=> #<Owner:0x00007f91b9340240 id: 3, name: "Altaf">
[6] pry(#<OwnersController>)> @owner.pets
=> [#<Pet:0x00007f91b84759b8 id: 1, name: "Maddy", owner_id: 3>, #<Pet:0x00007f91b8475788 id: 2, name: "Nona", owner_id: 3>]


as demonstrated here:
=> [#<Owner:0x00007f91b859e970 id: 1, name: "Sophie">, #<Owner:0x00007f91b859e808 id: 2, name: "Altaf">, #<Owner:0x00007f91b859e6a0 id: 3, name: "Altaf">]
[8] pry(#<OwnersController>)> 