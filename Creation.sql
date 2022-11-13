DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Purchases;


create table if not exists Users(
	user_id		int GENERATED ALWAYS AS IDENTITY,
	age			integer CHECK (age<150),
	PRIMARY KEY(user_id)
);

create table if not exists Items(
	item_id		int GENERATED ALWAYS AS IDENTITY,
	price numeric CONSTRAINT positive_price CHECK (price > 0),
	PRIMARY KEY(item_id)
);

create table if not exists Purchases(
	purchase_id		int GENERATED ALWAYS AS IDENTITY,
	date			TIMESTAMP NOT null,
	PRIMARY KEY(purchase_id),
	user_id int REFERENCES Users,
    item_id int REFERENCES Items
);


